CLANDRO_PKG_HOMEPAGE=https://pidgin.im/
CLANDRO_PKG_DESCRIPTION="Multi-protocol instant messaging client"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# please sync version and patches with packages/finch
CLANDRO_PKG_VERSION="2.14.14"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pidgin/pidgin-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=0ffc9994def10260f98a55cd132deefa8dc4a9835451cc0e982747bd458e2356
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, dbus, dbus-glib, fontconfig, freetype, gdk-pixbuf, glib, gst-plugins-base, gstreamer, gtk2, harfbuzz, libcairo, libgnt, libgnutls, libice, libidn, libsasl, libsm, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxinerama, libxml2, libxrandr, libxrender, libxss, ncurses, pango, tcl, tk"
CLANDRO_PKG_CONFLICTS="finch"
CLANDRO_PKG_REPLACES="finch"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-avahi
--disable-gevolution
--disable-gtkspell
--disable-meanwhile
--disable-perl
--disable-nm
--disable-vv
"

clandro_step_pre_configure() {
	# link-with-libpurple.patch resolves "dlopen failed: cannot locate symbol"
	# issues but this error is present on other distro so unlikely a problem:
	# lib/purple-2/libjabber.so is not usable because the 'purple_init_plugin' symbol could not be found. Does the plugin call the PURPLE_INIT_PLUGIN() macro?
	autoreconf -vfi
}

clandro_step_post_make_install() {
	# plugins: usr/lib/purple-2/libxmpp.so is not loadable: dlopen failed: library "libjabber.so" not found
	cd $CLANDRO_PREFIX/lib
	for lib in jabber; do
		[[ ! -f purple-2/lib${lib}.so ]] && continue
		ln -fsv purple-2/lib${lib}.so .
	done
}
