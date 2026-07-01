#!/usr/bin/env bash
# proot-distro plugin: Alpine Linux XFCE (Mobile Desktop)
DISTRO_NAME="Alpine XFCE (Mobile Desktop)"
DISTRO_COMMENT="Lightweight Alpine Linux with XFCE4, VNC, and mobile-friendly UI"

TARBALL_URLS=(
    "https://github.com/cl-andro/cl-andro-packages/releases/download/alpine-xfce/alpine-xfce-aarch64.tar.gz"
)

distro_setup() {
    run_proot_cmd /bin/true
    local tarball="${DISTRO_DIR}/alpine-xfce-aarch64.tar.gz"
    if [ -f "$tarball" ]; then
        msg "Installing Alpine XFCE from local tarball..."
        tar -xzf "$tarball" -C "$DISTRO_DIR"
        rm -f "$tarball"
        return 0
    fi
    msg "No local tarball found. Attempting download..."
    return 1
}

distro_post_install() {
    msg "Configuring Alpine XFCE for Android..."
    echo "nameserver 8.8.8.8" > "${DISTRO_DIR}/etc/resolv.conf"
    echo "nameserver 1.1.1.1" >> "${DISTRO_DIR}/etc/resolv.conf"
    mkdir -p "${DISTRO_DIR}/sdcard"
    mkdir -p "${DISTRO_DIR}/data/data/com.zk.clandro"
    if [ -f "${DISTRO_DIR}/home/clandro/.vnc/passwd" ]; then
        chmod 600 "${DISTRO_DIR}/home/clandro/.vnc/passwd"
    fi
    msg "Done! Start with:  proot-distro login alpine-xfce"
    msg "Then run:          clandro-xfce"
    msg "Connect VNC to:    localhost:1"
}
