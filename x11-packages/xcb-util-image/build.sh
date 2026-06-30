CLANDRO_PKG_HOMEPAGE=https://xcb.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Utility libraries for XC Binding - Port of Xlib's XImage and XShmImage functions"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://xcb.freedesktop.org/dist/xcb-util-image-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=ccad8ee5dadb1271fd4727ad14d9bd77a64e505608766c4e98267d9aede40d3d
CLANDRO_PKG_DEPENDS="libandroid-shmem, libxcb, xcb-util"
CLANDRO_PKG_BUILD_DEPENDS="xorg-util-macros"

clandro_step_pre_configure() {
	LDFLAGS+=' -landroid-shmem'
}
