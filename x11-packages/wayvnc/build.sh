CLANDRO_PKG_HOMEPAGE=https://github.com/any1/wayvnc
CLANDRO_PKG_DESCRIPTION="A VNC server for wlroots based Wayland compositors"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.0"
CLANDRO_PKG_SRCURL=https://github.com/any1/wayvnc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fcfda018d0e07ec00a80071420c8cc2a75885dc6d5e55bb50a9b12353754338f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libaml, libdrm, libjansson, libneatvnc, libpixman, libwayland, libxkbcommon"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-protocols, scdoc"
CLANDRO_PKG_SUGGESTS="sway"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dman-pages=enabled
-Dscreencopy-dmabuf=disabled
-Dpam=disabled
"
