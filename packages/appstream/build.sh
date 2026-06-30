CLANDRO_PKG_HOMEPAGE="https://www.freedesktop.org/wiki/Distributions/AppStream/"
CLANDRO_PKG_DESCRIPTION="Provides a standard for creating app stores across distributions"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.2"
CLANDRO_PKG_SRCURL=https://github.com/ximion/appstream/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=564ec87b16e9e4ee81fb021e612250fd27f3a3ecd31c209a5dd1ff59def3022d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="curl, glib, libfyaml, libxml2, libxmlb, zstd"
CLANDRO_PKG_BUILD_DEPENDS="bash-completion, g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dapidocs=false
-Ddocs=false
-Dgir=true
-Dstemming=false
-Dsystemd=false
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
