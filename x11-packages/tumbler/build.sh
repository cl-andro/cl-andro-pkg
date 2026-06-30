CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/tumbler/start
CLANDRO_PKG_DESCRIPTION="Tumbler is a D-Bus service for applications to request thumbnails for various URI schemes and MIME type"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.1"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/tumbler/${CLANDRO_PKG_VERSION%.*}/tumbler-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=87b90df8f30144a292d70889e710c8619d8b8803f0e1db3280a4293367a42eae
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, gdk-pixbuf, glib, libcurl, libjpeg-turbo, libpng, libxfce4util"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/systemd"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--enable-gtk-doc-html=no
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
