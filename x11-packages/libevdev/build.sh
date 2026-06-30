CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/libevdev/
CLANDRO_PKG_DESCRIPTION="Wrapper library for evdev devices"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.6"
CLANDRO_PKG_SRCURL=https://www.freedesktop.org/software/libevdev/libevdev-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=73f215eccbd8233f414737ac06bca2687e67c44b97d2d7576091aa9718551110
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-test-run"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/man/man1/
"

clandro_step_pre_configure() {
	autoreconf -i
}
