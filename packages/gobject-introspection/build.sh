CLANDRO_PKG_HOMEPAGE=https://gi.readthedocs.io/
CLANDRO_PKG_DESCRIPTION="Uniform machine readable API"
CLANDRO_PKG_LICENSE="LGPL-2.0, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.86.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gobject-introspection/${CLANDRO_PKG_VERSION%.*}/gobject-introspection-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=920d1a3fcedeadc32acff95c2e203b319039dd4b4a08dd1a2dfd283d19c0b9ae
CLANDRO_PKG_DEPENDS="glib, libffi"
CLANDRO_PKG_SUGGESTS="g-ir-scanner"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="packaging, wheel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dcairo_libname=libcairo-gobject.so
-Dpython=python
-Dbuild_introspection_data=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
		-Dgi_cross_binary_wrapper=$GI_CROSS_LAUNCHER
		"
	unset GI_CROSS_LAUNCHER
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
			-Dgi_cross_use_prebuilt_gi=true
			-Dgi_cross_ldd_wrapper=$(command -v ldd)
			"
	fi

	echo "Applying meson-python.diff"
	sed "s%@PYTHON_VERSION@%$CLANDRO_PYTHON_VERSION%g" \
		$CLANDRO_PKG_BUILDER_DIR/meson-python.diff | patch --silent -p1

	CPPFLAGS+="
		-I$CLANDRO_PREFIX/include/python${CLANDRO_PYTHON_VERSION}
		-I$CLANDRO_PREFIX/include/python${CLANDRO_PYTHON_VERSION}/cpython
		"
}
