CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/ristretto/start
CLANDRO_PKG_DESCRIPTION="The Ristretto Image Viewer is an application that can be used to view, and scroll through images."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.0"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/ristretto/${CLANDRO_PKG_VERSION%.*}/ristretto-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=502cf1577de14b38132dc89e56884c5e10f86f6a028d8dde379a8839110fda55
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="exo, file, gdk-pixbuf, glib, gtk3, libcairo, libexif, libx11, libxfce4ui, libxfce4util, pango, xfconf"
CLANDRO_PKG_RECOMMENDS="tumbler"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
