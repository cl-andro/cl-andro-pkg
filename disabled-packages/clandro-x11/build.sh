CLANDRO_PKG_HOMEPAGE=https://github.com/termux/x11-packages
CLANDRO_PKG_DESCRIPTION="Utility to start X11 Termux add-on"
CLANDRO_PKG_LICENSE="GPL-3.0" # same as Termux:X11 add-on app
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_DEPENDS="libwayland"

clandro_step_make_install() {
	$CC $CFLAGS $CPPFLAGS -DTERMUX_PREFIX=\"$CLANDRO_PREFIX\" \
		$CLANDRO_PKG_BUILDER_DIR/clandro-x11.c -o $CLANDRO_PREFIX/bin/clandro-x11 \
		$LDFLAGS -lwayland-client
}
