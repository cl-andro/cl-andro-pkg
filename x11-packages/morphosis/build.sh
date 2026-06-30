CLANDRO_PKG_HOMEPAGE="https://gitlab.gnome.org/World/morphosis"
CLANDRO_PKG_DESCRIPTION="Convert your documents"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://gitlab.gnome.org/World/morphosis/-/archive/${CLANDRO_PKG_VERSION}/morphosis-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="336e4c680205651e2376357f118c5cbdaa4006c22d9a886717f7eb3c1bac5c3c"
CLANDRO_PKG_DEPENDS="gtk4, libadwaita, pandoc, pygobject, python, python-pip, python-pillow"
CLANDRO_PKG_BUILD_DEPENDS="blueprint-compiler, glib-cross"
CLANDRO_PKG_PYTHON_RUNTIME_DEPS="weasyprint"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dprofile=release
"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686" # pandoc doesn't support 32bit

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_bpc
	echo "Applying fix-python-install-dir.diff"
	sed "s%@PYTHON_VERSION@%$CLANDRO_PYTHON_VERSION%g" \
		$CLANDRO_PKG_BUILDER_DIR/fix-python-install-dir.diff | patch --silent -p1
}
