# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.Org X11 Protocol headers"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="COPYING-bigreqsproto, COPYING-compositeproto, COPYING-damageproto, COPYING-dmxproto, COPYING-dri2proto, COPYING-dri3proto, COPYING-evieproto, COPYING-fixesproto, COPYING-fontcacheproto, COPYING-fontsproto, COPYING-glproto, COPYING-inputproto, COPYING-kbproto, COPYING-lg3dproto, COPYING-pmproto, COPYING-presentproto, COPYING-printproto, COPYING-randrproto, COPYING-recordproto, COPYING-renderproto, COPYING-resourceproto, COPYING-scrnsaverproto, COPYING-trapproto, COPYING-videoproto, COPYING-x11proto, COPYING-xcmiscproto, COPYING-xextproto, COPYING-xf86bigfontproto, COPYING-xf86dgaproto, COPYING-xf86driproto, COPYING-xf86miscproto, COPYING-xf86rushproto, COPYING-xf86vidmodeproto, COPYING-xineramaproto, COPYING-xwaylandproto"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.1"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/proto/xorgproto-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=56898c716c0578df8a2d828c9c3e5c528277705c0484381a81960fe1a67668e8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="xorg-util-macros"
CLANDRO_PKG_CONFLICTS="x11-proto"
CLANDRO_PKG_REPLACES="x11-proto"
CLANDRO_PKG_NO_DEVELSPLIT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Dlegacy=true"

CLANDRO_PKG_RM_AFTER_INSTALL="
include/X11/extensions/apple*
include/X11/extensions/windows*
include/X11/extensions/XKBgeom.h
lib/pkgconfig/applewmproto.pc
lib/pkgconfig/windowswmproto.pc
"

clandro_step_pre_configure() {
	# Use meson instead of autotools.
	rm -f "$CLANDRO_PKG_SRCDIR"/configure
}
