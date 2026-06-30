CLANDRO_PKG_HOMEPAGE="https://gitlab.freedesktop.org/geoclue/geoclue/-/wikis/home"
CLANDRO_PKG_DESCRIPTION="Modular geoinformation service built on the D-Bus messaging system"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.1"
CLANDRO_PKG_SRCURL="https://gitlab.freedesktop.org/geoclue/geoclue/-/archive/${CLANDRO_PKG_VERSION}/geoclue-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=29dd143845ef270a06971c9edc98cdcf71aaad114cfb48dd1c803269c389a483
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, json-glib, libnotify, libsoup3"
CLANDRO_PKG_BUILD_DEPENDS="gobject-introspection, libnotify"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dmodem-gps-source=false
-D3g-source=false
-Dcdma-source=false
-Dintrospection=true
-Dnmea-source=false
-Dgtk-doc=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
