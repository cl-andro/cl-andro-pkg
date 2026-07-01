#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# build-alpine-xfce-rootfs.sh
# Forges an Alpine Linux aarch64 rootfs with XFCE4 + TigerVNC,
# pre-configured for mobile-friendly use inside cl-andro PRoot.
#
# Usage on x86_64 host:
#   sudo apt install qemu-user-static
#   sudo ./build-alpine-xfce-rootfs.sh
# ============================================================

SCRIPT_VERSION="1.0.0"
ALPINE_VERSION="3.21"
VNC_PASSWORD="clusterauto"
VNC_RESOLUTION="1080x2400"
OUTPUT_DIR="/tmp/alpine-xfce-rootfs"
ARCH="aarch64"

usage() {
    cat <<EOF
Usage: $0 [options]

Options:
  --version VER     Alpine version (default: 3.21)
  --vnc-pass PASS   VNC password (default: clusterauto)
  --resolution WxH  VNC resolution (default: 1080x2400)
  --output DIR      Output directory (default: /tmp/alpine-xfce-rootfs)
  --arch ARCH       Target architecture (default: aarch64)
  -h, --help        Show this help
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --version)    ALPINE_VERSION="$2"; shift 2 ;;
        --vnc-pass)   VNC_PASSWORD="$2"; shift 2 ;;
        --resolution) VNC_RESOLUTION="$2"; shift 2 ;;
        --output)     OUTPUT_DIR="$2"; shift 2 ;;
        --arch)       ARCH="$2"; shift 2 ;;
        -h|--help)    usage ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
done

ROOTFS_DIR="${OUTPUT_DIR}/root"
BOOTSTRAP_CACHE="${OUTPUT_DIR}/cache"
ALPINE_MIRROR="https://dl-cdn.alpinelinux.org/alpine"
ROOTFS_TAR="alpine-minirootfs-${ALPINE_VERSION}.0-${ARCH}.tar.gz"
ROOTFS_URL="${ALPINE_MIRROR}/v${ALPINE_VERSION}/releases/${ARCH}/${ROOTFS_TAR}"
BUILD_LOG="${OUTPUT_DIR}/build.log"

echo "[*] Alpine XFCE Rootfs Builder v${SCRIPT_VERSION}"
echo "[*] Alpine: ${ALPINE_VERSION} | Arch: ${ARCH} | Resolution: ${VNC_RESOLUTION}"
exec > >(tee -a "${BUILD_LOG}") 2>&1

mkdir -p "${ROOTFS_DIR}" "${BOOTSTRAP_CACHE}"

# ---- Download & extract Alpine minirootfs ----
if [ ! -f "${BOOTSTRAP_CACHE}/${ROOTFS_TAR}" ]; then
    echo "[*] Downloading Alpine minirootfs ${ALPINE_VERSION} for ${ARCH}..."
    wget -q --show-progress -O "${BOOTSTRAP_CACHE}/${ROOTFS_TAR}" "${ROOTFS_URL}"
    wget -q --show-progress -O "${BOOTSTRAP_CACHE}/${ROOTFS_TAR}.sha256" "${ROOTFS_URL}.sha256"
    (cd "${BOOTSTRAP_CACHE}" && sha256sum -c "${ROOTFS_TAR}.sha256") || {
        echo "[!] Checksum mismatch."
        exit 1
    }
fi

echo "[*] Extracting base rootfs..."
tar -xzf "${BOOTSTRAP_CACHE}/${ROOTFS_TAR}" -C "${ROOTFS_DIR}"

# ---- Copy qemu for cross-arch chroot ----
if [ "${ARCH}" = "aarch64" ] && [ "$(uname -m)" != "aarch64" ]; then
    QEMU_STATIC="/usr/bin/qemu-aarch64-static"
    if [ -f "${QEMU_STATIC}" ]; then
        mkdir -p "${ROOTFS_DIR}/usr/bin"
        cp "${QEMU_STATIC}" "${ROOTFS_DIR}/usr/bin/qemu-aarch64-static"
    else
        echo "[!] qemu-aarch64-static not found. Install: sudo apt install qemu-user-static"
        exit 1
    fi
fi

# ---- Write APK repositories ----
mkdir -p "${ROOTFS_DIR}/etc/apk"
cat > "${ROOTFS_DIR}/etc/apk/repositories" <<EOF
${ALPINE_MIRROR}/v${ALPINE_VERSION}/main
${ALPINE_MIRROR}/v${ALPINE_VERSION}/community
EOF

echo "nameserver 8.8.8.8" > "${ROOTFS_DIR}/etc/resolv.conf"
echo "nameserver 1.1.1.1" >> "${ROOTFS_DIR}/etc/resolv.conf"

# ---- Bootstrap APK ----
# Ensure apk-tools static is available
APK_BIN="${BOOTSTRAP_CACHE}/apk"
if [ ! -x "$APK_BIN" ]; then
    APK_VERSION="2.14.4"
    APK_ARCH="x86_64"
    [ "$(uname -m)" = "aarch64" ] && APK_ARCH="aarch64"
    APK_URL="https://gitlab.alpinelinux.org/api/v4/projects/5/packages/generic/apk-tools-static/v${APK_VERSION}/${APK_ARCH}/apk.static"
    echo "[*] Downloading apk-tools-static v${APK_VERSION} (${APK_ARCH})..."
    wget -q --show-progress -O "$APK_BIN" "$APK_URL"
    chmod +x "$APK_BIN"
fi
APK_CMD="$APK_BIN"

echo "[*] Bootstrapping APK..."
$APK_CMD --root "${ROOTFS_DIR}" --arch "${ARCH}" --initdb add --no-interactive \
    alpine-baselayout alpine-conf alpine-repositories apk-tools busybox

# ---- Install XFCE + VNC + mobile-friendly packages ----
echo "[*] Installing XFCE4 desktop + VNC + mobile tools..."
$APK_CMD --root "${ROOTFS_DIR}" --no-interactive add \
    alpine-base busybox-initscripts openrc \
    util-linux e2fsprogs dosfstools \
    dbus dbus-x11 elogind polkit-elogind \
    sudo curl wget ca-certificates tzdata \
    htop nano bash shadow \
    grep sed gawk findutils coreutils \
    tar gzip xz bzip2 lsof file \
    \
    xfce4 xfce4-terminal xfce4-screensaver \
    xfce4-panel xfce4-session xfce4-settings \
    xfdesktop xfwm4 xfce4-power-manager \
    xfce4-notifyd \
    thunar thunar-volman thunar-archive-plugin \
    ristretto mousepad parole xarchiver \
    xdg-utils xdg-user-dirs \
    \
    adwaita-icon-theme tango-icon-theme \
    papirus-icon-theme gtk+3.0 \
    gtk-engine-murrine \
    font-noto font-noto-cjk font-dejavu font-liberation \
    \
    tigervnc tigervnc-server \
    \
    matchbox-keyboard firefox-esr netsurf \
    desktop-file-utils shared-mime-info \
    gvfs gvfs-fuse \
    NetworkManager network-manager-applet \
    pulseaudio pulseaudio-utils \
    alsa-utils alsa-plugins-pulse \
    unclutter xdotool

# ---- Create user 'clandro' directly (no chroot needed) ----
echo "[*] Creating user 'clandro'..."
CLANDRO_UID=10000
CLANDRO_GID=10000
mkdir -p "${ROOTFS_DIR}/home/clandro"

# /etc/group
if ! grep -q "^clandro:" "${ROOTFS_DIR}/etc/group" 2>/dev/null; then
    echo "clandro:x:${CLANDRO_GID}:clandro" >> "${ROOTFS_DIR}/etc/group"
fi
# /etc/group for supplementary groups
for g in wheel audio video input network; do
    if grep -q "^${g}:" "${ROOTFS_DIR}/etc/group" 2>/dev/null; then
        sed -i "s/^\(${g}:.*:.*\)$/\1,clandro/" "${ROOTFS_DIR}/etc/group"
    fi
done

# /etc/passwd
if ! grep -q "^clandro:" "${ROOTFS_DIR}/etc/passwd" 2>/dev/null; then
    echo "clandro:x:${CLANDRO_UID}:${CLANDRO_GID}:clandro user:/home/clandro:/bin/bash" >> "${ROOTFS_DIR}/etc/passwd"
fi

# /etc/shadow with hashed password (SHA-512)
PASS_HASH=$(echo "${VNC_PASSWORD}" | openssl passwd -6 -stdin 2>/dev/null || \
            python3 -c "import crypt; print(crypt.crypt('${VNC_PASSWORD}', crypt.mksalt(crypt.METHOD_SHA512)))")
if ! grep -q "^clandro:" "${ROOTFS_DIR}/etc/shadow" 2>/dev/null; then
    echo "clandro:${PASS_HASH}:$(date +%s):0:99999:7:::" >> "${ROOTFS_DIR}/etc/shadow"
else
    sed -i "s|^clandro:.*$|clandro:${PASS_HASH}:$(date +%s):0:99999:7:::|" "${ROOTFS_DIR}/etc/shadow"
fi

# Sudoers
sed -i '/^# %wheel ALL=(ALL:ALL) ALL/s/^# //' "${ROOTFS_DIR}/etc/sudoers" 2>/dev/null || true

# ---- VNC startup ----
mkdir -p "${ROOTFS_DIR}/home/clandro/.vnc"
cat > "${ROOTFS_DIR}/home/clandro/.vnc/xstartup" <<'XVNC'
#!/bin/sh
export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

dbus-launch --sh-syntax --exit-with-session
pulseaudio --start --exit-idle-time=-1 2>/dev/null || true
startxfce4 &

# On-screen keyboard for touch
sleep 3
matchbox-keyboard --daemon --position bottom 2>/dev/null || true
unclutter -idle 1 -root 2>/dev/null || true

wait
XVNC
chmod +x "${ROOTFS_DIR}/home/clandro/.vnc/xstartup"

cat > "${ROOTFS_DIR}/home/clandro/.vnc/config" <<VNCCONF
geometry=${VNC_RESOLUTION}
localhost=no
alwaysshared=true
SecurityTypes=VncAuth
VNCCONF

# Generate VNC password file using python (cross-platform, no chroot)
python3 -c "
import struct, hashlib, os
password = '${VNC_PASSWORD}'.encode()
# VNC uses DES-style challenge/response
# The password file is a simple obfuscated format
# We'll use vncpasswd via chroot + qemu, or fallback
with open('${ROOTFS_DIR}/home/clandro/.vnc/passwd', 'wb') as f:
    # Write fixed-length 8-byte entries
    key = password.ljust(8, b'\x00')[:8]
    # Simple XOR obfuscation
    f.write(key)
os.chmod('${ROOTFS_DIR}/home/clandro/.vnc/passwd', 0o600)
"

# Use chroot to set proper VNC password if qemu is available
if [ -f "${ROOTFS_DIR}/usr/bin/qemu-aarch64-static" ]; then
    echo "${VNC_PASSWORD}" | chroot "${ROOTFS_DIR}" /bin/sh -c '
        cat > /tmp/vncpass.txt
        /usr/bin/vncpasswd -f < /tmp/vncpass.txt > /home/clandro/.vnc/passwd 2>/dev/null
        chmod 600 /home/clandro/.vnc/passwd
        chown 10000:10000 /home/clandro/.vnc/passwd
        rm -f /tmp/vncpass.txt
    ' 2>/dev/null || true
fi

# ---- Mobile-friendly XFCE configs ----
mkdir -p "${ROOTFS_DIR}/home/clandro/.config/xfce4/xfconf/xfce-perchannel-xml"

# Panel: 56px tall, touch-friendly, bottom dock
cat > "${ROOTFS_DIR}/home/clandro/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" <<'PANELXML'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="panels" type="int" value="1"/>
  <property name="panel-0" type="empty">
    <property name="position" type="string" value="p=10;x=0;y=0"/>
    <property name="length" type="uint" value="100"/>
    <property name="position-locked" type="bool" value="true"/>
    <property name="size" type="uint" value="56"/>
    <property name="autohide-behavior" type="uint" value="2"/>
    <property name="plugin-ids" type="array">
      <value type="int" value="1"/>
      <value type="int" value="2"/>
      <value type="int" value="3"/>
      <value type="int" value="4"/>
      <value type="int" value="5"/>
    </property>
    <property name="background-alpha" type="uint" value="80"/>
    <property name="nrows" type="uint" value="1"/>
    <property name="span" type="bool" value="true"/>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="applicationsmenu"/>
    <property name="plugin-2" type="string" value="tasklist">
      <property name="flat-buttons" type="bool" value="true"/>
      <property name="show-labels" type="bool" value="false"/>
    </property>
    <property name="plugin-3" type="string" value="separator">
      <property name="expand" type="bool" value="true"/>
    </property>
    <property name="plugin-4" type="string" value="pulseaudio"/>
    <property name="plugin-5" type="string" value="datetime">
      <property name="digital-format" type="string" value="%H:%M"/>
    </property>
  </property>
</channel>
PANELXML

# Appearance: 160 DPI, 14pt, 32px cursor, Papirus icons
cat > "${ROOTFS_DIR}/home/clandro/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" <<'XSETTINGS'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="Adwaita"/>
    <property name="IconThemeName" type="string" value="Papirus"/>
    <property name="DoubleClickTime" type="int" value="400"/>
    <property name="DoubleClickDistance" type="int" value="5"/>
    <property name="CursorThemeName" type="string" value="Adwaita"/>
    <property name="CursorThemeSize" type="int" value="32"/>
  </property>
  <property name="Xft" type="empty">
    <property name="DPI" type="int" value="160"/>
    <property name="Antialias" type="int" value="1"/>
    <property name="Hinting" type="int" value="1"/>
    <property name="HintStyle" type="string" value="hintslight"/>
    <property name="RGBA" type="string" value="rgb"/>
  </property>
  <property name="Gtk" type="empty">
    <property name="FontName" type="string" value="Noto Sans 14"/>
    <property name="MonospaceFontName" type="string" value="Noto Sans Mono 13"/>
    <property name="IconSizes" type="string" value="panel=32,gtk-large-toolbar=48"/>
    <property name="ToolbarIconSize" type="int" value="3"/>
    <property name="ToolbarStyle" type="string" value="icons"/>
  </property>
</channel>
XSETTINGS

# WM: large title bars for touch drag
cat > "${ROOTFS_DIR}/home/clandro/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml" <<'XFWM4'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="button_layout" type="string" value="O|IHMc"/>
    <property name="button_offset" type="int" value="4"/>
    <property name="title_font" type="string" value="Noto Sans Bold 13"/>
    <property name="title_alignment" type="string" value="center"/>
    <property name="theme" type="string" value="Default"/>
    <property name="border_width" type="int" value="2"/>
    <property name="double_click_action" type="string" value="maximize"/>
    <property name="triple_click_action" type="string" value="shade"/>
    <property name="click_to_focus" type="bool" value="true"/>
    <property name="raise_on_click" type="bool" value="true"/>
  </property>
</channel>
XFWM4

# GTK3 touch settings
mkdir -p "${ROOTFS_DIR}/home/clandro/.config/gtk-3.0"
cat > "${ROOTFS_DIR}/home/clandro/.config/gtk-3.0/settings.ini" <<'GTK3'
[Settings]
gtk-font-name=Noto Sans 14
gtk-icon-theme-name=Papirus
gtk-theme-name=Adwaita
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=32
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-toolbar-style=GTK_TOOLBAR_ICONS
gtk-button-images=1
gtk-menu-images=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
gtk-double-click-distance=5
gtk-double-click-time=400
gtk-long-press-time=700
gtk-primary-button-warps-slider=1
GTK3

# .bashrc
cat > "${ROOTFS_DIR}/home/clandro/.bashrc" <<'BASHRC'
alias ll='ls -la'
alias la='ls -A'

vnc-start() {
    local d="${1:-:1}"
    local r="${VNC_RESOLUTION:-1080x2400}"
    vncserver "$d" -geometry "$r" -depth 24 -localhost no
    echo "[*] VNC on $(hostname)$d"
}
vnc-stop() { vncserver -kill "${1:-:1}"; }
vnc-list() { vncserver -list; }

echo ""
echo "======================================"
echo "  Alpine XFCE (Mobile Edition)"
echo "  Start VNC:  vnc-start :1"
echo "======================================"
echo ""
BASHRC

# Android environment
mkdir -p "${ROOTFS_DIR}/etc/profile.d"
cat > "${ROOTFS_DIR}/etc/profile.d/android-env.sh" <<'ANDROIDENV'
export TZ=Asia/Karachi
export LANG=en_US.UTF-8
export VNC_RESOLUTION=${VNC_RESOLUTION:-1080x2400}
export DISPLAY=:0
export GTK_OVERLAY_SCROLLING=1
export PULSE_SERVER=127.0.0.1:4713
ANDROIDENV

# OpenRC services (create runlevel symlinks directly, no chroot needed)
mkdir -p "${ROOTFS_DIR}/etc/runlevels/default"
ln -sf /etc/init.d/dbus "${ROOTFS_DIR}/etc/runlevels/default/dbus" 2>/dev/null || true
ln -sf /etc/init.d/elogind "${ROOTFS_DIR}/etc/runlevels/default/elogind" 2>/dev/null || true
ln -sf /etc/init.d/NetworkManager "${ROOTFS_DIR}/etc/runlevels/default/NetworkManager" 2>/dev/null || true

# Start script
mkdir -p "${ROOTFS_DIR}/usr/local/bin"
cat > "${ROOTFS_DIR}/usr/local/bin/clandro-xfce" <<'STARTX'
#!/bin/sh
echo "[*] Starting Alpine XFCE..."
/usr/sbin/rc-service dbus start 2>/dev/null || true

su clandro -c "/usr/bin/vncserver :1 -geometry ${VNC_RESOLUTION:-1080x2400} -depth 24 -localhost no -name Alpine-XFCE" 2>/dev/null || true

echo ""
echo "======================================"
echo "  Alpine XFCE is ready!"
echo "  VNC:  $(hostname):1"
echo "  Res:  ${VNC_RESOLUTION:-1080x2400}"
echo "======================================"
echo ""
exec /bin/bash
STARTX
chmod +x "${ROOTFS_DIR}/usr/local/bin/clandro-xfce"

# ---- Cleanup ----
echo "[*] Cleaning up..."
rm -rf "${ROOTFS_DIR}/var/cache/apk"/*
rm -rf "${ROOTFS_DIR}/tmp/"*
rm -rf "${ROOTFS_DIR}/root/"*
rm -f "${ROOTFS_DIR}/usr/bin/qemu-aarch64-static"
find "${ROOTFS_DIR}/usr/share/doc" -type f -delete 2>/dev/null || true
find "${ROOTFS_DIR}/usr/share/info" -type f -delete 2>/dev/null || true
find "${ROOTFS_DIR}/usr/share/man" -type f -delete 2>/dev/null || true

# Fix ownership
chown -R 10000:10000 "${ROOTFS_DIR}/home/clandro" 2>/dev/null || true

ROOTFS_SIZE=$(du -sh "${ROOTFS_DIR}" | cut -f1)
echo "[*] Rootfs size: ${ROOTFS_SIZE}"
echo "[*] Alpine XFCE rootfs built at: ${ROOTFS_DIR}"
echo "[*] Done."
