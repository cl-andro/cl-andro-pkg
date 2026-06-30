CLANDRO_PKG_HOMEPAGE=https://github.com/LibVNC/x11vnc
CLANDRO_PKG_DESCRIPTION="VNC server for real X displays"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.17"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/LibVNC/x11vnc/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3ab47c042bc1c33f00c7e9273ab674665b85ab10592a8e0425589fe7f3eb1a69
CLANDRO_PKG_DEPENDS="libandroid-shmem, libcairo, libvncserver, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxrandr, libxtst, openssl, xorg-xdpyinfo"

# https://github.com/termux/termux-packages/issues/15240
CLANDRO_PKG_RM_AFTER_INSTALL="bin/Xdummy"

clandro_step_pre_configure() {
	autoreconf -vi
	export LIBS="-landroid-shmem"
}
