CLANDRO_PKG_HOMEPAGE=https://pygobject.gnome.org/
CLANDRO_PKG_DESCRIPTION="Python package which provides bindings for GObject based libraries"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.56.3"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/pygobject/${CLANDRO_PKG_VERSION%.*}/pygobject-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=12760e4a0e3d04b6eb95e06f7a27e362c826d567ea613373a92c003b6c70d2d6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gobject-introspection, libcairo, libffi, pycairo, python"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dpycairo=enabled
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
