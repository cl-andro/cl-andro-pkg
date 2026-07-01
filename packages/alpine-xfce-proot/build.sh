CLANDRO_PKG_HOMEPAGE=https://github.com/anomalyco/clandro-pkg
CLANDRO_PKG_DESCRIPTION="Alpine Linux XFCE Mobile Desktop - PRoot distro integration for cl-andro"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.0"
CLANDRO_PKG_REVISION="1"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="proot, proot-distro, bash, coreutils"
CLANDRO_PKG_SUGGESTS="clusterctl"
CLANDRO_PKG_CONFFILES="etc/proot-distro/alpine-xfce.sh"

clandro_step_make_install() {
    mkdir -p "${CLANDRO_PREFIX}/etc/proot-distro"
    cp "${CLANDRO_PKG_SRCDIR}/alpine-xfce.sh" \
        "${CLANDRO_PREFIX}/etc/proot-distro/alpine-xfce.sh"
    chmod 644 "${CLANDRO_PREFIX}/etc/proot-distro/alpine-xfce.sh"

    mkdir -p "${CLANDRO_PREFIX}/bin"
    cp "${CLANDRO_PKG_SRCDIR}/clandro-xfce-start" \
        "${CLANDRO_PREFIX}/bin/clandro-xfce-start"
    chmod 755 "${CLANDRO_PREFIX}/bin/clandro-xfce-start"
}

clandro_step_create_debscripts() {
    cat <<'POSTINST' > "${CLANDRO_PKG_TMPDIR}/postinst"
#!/bin/sh
set -e

echo ""
echo "========================================="
echo "  Alpine XFCE Mobile Desktop"
echo "========================================="
echo ""

# Auto-download rootfs if proot-distro dir exists
DISTRO_DIR="${PREFIX}/var/lib/proot-distro/installed-distro/alpine-xfce"
RELEASE_URL="https://github.com/${CLANDRO_REPO:-cl-andro/cl-andro-packages}/releases/download/alpine-xfce-latest/alpine-xfce-aarch64.tar.gz"

if command -v proot-distro >/dev/null 2>&1; then
    if [ ! -d "$DISTRO_DIR" ]; then
        echo "  Rootfs not installed."
        echo "  Run:  proot-distro install alpine-xfce"
        echo ""
        echo "  Or:   clandro-xfce-start"
        echo "  (it will auto-download the rootfs)"
        echo ""
    else
        echo "  ✓ Rootfs already installed at: $DISTRO_DIR"
        echo "  Run:  clandro-xfce-start"
        echo ""
    fi
fi

echo "  VNC: localhost:1  |  Password: clusterauto"
echo "========================================="
echo ""
POSTINST

    cat <<'POSTRM' > "${CLANDRO_PKG_TMPDIR}/postrm"
#!/bin/sh
case "$1" in
    purge|remove)
        echo "Removing Alpine XFCE rootfs..."
        rm -rf "${PREFIX}/var/lib/proot-distro/installed-distro/alpine-xfce" 2>/dev/null || true
        ;;
esac
POSTRM
}
