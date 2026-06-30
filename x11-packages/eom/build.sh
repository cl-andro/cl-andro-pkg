CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Image viewer for MATE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/eom/releases/download/v$CLANDRO_PKG_VERSION/eom-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=ccc169b8e240828b36965dfd84fa1478957dec2028ffeba553ae97e542e15120
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus-glib, gobject-introspection, gettext, imagemagick, librsvg, littlecms, libexif, libjpeg-turbo, mate-desktop, libpeas"
CLANDRO_PKG_RECOMMENDS="webp-pixbuf-loader"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--localstatedir=$CLANDRO_PREFIX/var
-Dgdk-pixbuf-thumbnailer=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
