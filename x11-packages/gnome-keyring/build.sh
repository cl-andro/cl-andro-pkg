CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gnome-keyring
CLANDRO_PKG_DESCRIPTION="a collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gnome-keyring/-/archive/$CLANDRO_PKG_VERSION/gnome-keyring-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=22a14fc7fc49d50aa5a3edb8cdb3cad341a09043cee7991da1decc923cdb9de6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gcr"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dsystemd=disabled
-Dpam=false
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
