CLANDRO_PKG_HOMEPAGE=https://github.com/AyatanaIndicators/ayatana-ido
CLANDRO_PKG_DESCRIPTION="Ayatana Indicator Display Objects"
CLANDRO_PKG_LICENSE="LGPL-2.1, LGPL-3.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/AyatanaIndicators/ayatana-ido/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bd59abd5f1314e411d0d55ce3643e91cef633271f58126be529de5fb71c5ab38
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_TESTS=OFF
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
