CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/LibXklavier/
CLANDRO_PKG_DESCRIPTION="High-level API for X Keyboard Extension"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.4
CLANDRO_PKG_REVISION=28
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/archived-projects/libxklavier/-/archive/libxklavier-${CLANDRO_PKG_VERSION}/libxklavier-libxklavier-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e1638599e9229e6f6267b70b02e41940b98ba29b3a37e221f6e59ff90100c3da
CLANDRO_PKG_DEPENDS="glib, iso-codes, libx11, libxi, libxkbfile, libxml2, xkeyboard-config, xorg-xkbcomp"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
--with-xkb-base=$CLANDRO_PREFIX/share/X11/xkb
--with-xkb-bin-base=$CLANDRO_PREFIX/bin
"

clandro_step_pre_configure() {
	clandro_setup_gir

	NOCONFIGURE=1 ./autogen.sh
}
