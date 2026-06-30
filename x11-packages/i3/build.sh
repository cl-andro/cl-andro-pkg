CLANDRO_PKG_HOMEPAGE=https://i3wm.org/
CLANDRO_PKG_DESCRIPTION="An improved dynamic tiling window manager"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.25.1"
CLANDRO_PKG_SRCURL=https://i3wm.org/downloads/i3-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=4a742bbe81b9e5ee6057f42a8e3c691d88894e93f1a5d81fe239128512ac05c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libandroid-glob, libandroid-wordexp, libcairo, libev, libiconv, libxcb, libxkbcommon, pango, pcre2, perl, startup-notification, xcb-util, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm, xcb-util-xrm, yajl"
CLANDRO_PKG_RECOMMENDS="i3status"
CLANDRO_PKG_BREAKS="i3-gaps (<< 4.21.1)"
CLANDRO_PKG_REPLACES="i3-gaps (<< 4.21.1)"
CLANDRO_PKG_CONFFILES="
i3/config
i3/config.keycodes
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-wordexp"
}
