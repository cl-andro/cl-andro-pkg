CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/msitools
CLANDRO_PKG_DESCRIPTION="Set of programs to inspect and build Windows Installer (.MSI) files"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.106"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/msitools/${CLANDRO_PKG_VERSION}/msitools-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1ed34279cf8080f14f1b8f10e649474125492a089912e7ca70e59dfa2e5a659b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gcab, glib, libgsf, libxml2"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
