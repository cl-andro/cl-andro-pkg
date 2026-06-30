CLANDRO_PKG_HOMEPAGE=https://github.com/AyatanaIndicators/libayatana-appindicator
CLANDRO_PKG_DESCRIPTION="Ayatana Application Indicators"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-2.1, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.94"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/AyatanaIndicators/libayatana-appindicator/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=884a6bc77994c0b58c961613ca4c4b974dc91aa0f804e70e92f38a542d0d0f90
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="glib, gtk3, libayatana-indicator, libdbusmenu, libdbusmenu-gtk3"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_BINDINGS_MONO=OFF
-DENABLE_GTKDOC=OFF
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
