CLANDRO_PKG_HOMEPAGE=https://dopewars.sourceforge.io
CLANDRO_PKG_DESCRIPTION="Drug-dealing game set in streets of New York City"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://prdownloads.sourceforge.net/dopewars/dopewars-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=623b9d1d4d576f8b1155150975308861c4ec23a78f9cc2b24913b022764eaae1
CLANDRO_PKG_DEPENDS="glib, libcurl, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-sdl
"
CLANDRO_PKG_RM_AFTER_INSTALL="share/gnome"
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure() {
	autoreconf -vfi
}
