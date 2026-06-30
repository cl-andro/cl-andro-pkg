CLANDRO_PKG_HOMEPAGE=https://matplotlib.org/
CLANDRO_PKG_DESCRIPTION="A comprehensive library for creating static, animated, and interactive visualizations in Python"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="\
LICENSE/LICENSE
LICENSE/LICENSE_AMSFONTS
LICENSE/LICENSE_BAKOMA
LICENSE/LICENSE_CARLOGO
LICENSE/LICENSE_COLORBREWER
LICENSE/LICENSE_COURIERTEN
LICENSE/LICENSE_JSXTOOLS_RESIZE_OBSERVER
LICENSE/LICENSE_QT4_EDITOR
LICENSE/LICENSE_SOLARIZED
LICENSE/LICENSE_STIX
LICENSE/LICENSE_YORICK"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.10.9"
CLANDRO_PKG_SRCURL="https://github.com/matplotlib/matplotlib/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=55251fcbca725a3b7ed20aefaff07a67560ffb0a7d739ebab0c99eb14f4c2d94
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, libc++, patchelf, ninja, python, python-contourpy, python-numpy, python-pillow, python-pip"
_NUMPY_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/python-numpy/build.sh; echo $CLANDRO_PKG_VERSION)
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, 'meson-python>=0.13.1', wheel, 'numpy==$_NUMPY_VERSION', 'pybind11>=2.6.0', 'setuptools>=64', 'setuptools_scm>=7'"

CLANDRO_MESON_WHEEL_CROSSFILE="$CLANDRO_PKG_TMPDIR/wheel-cross-file.txt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cross-file $CLANDRO_MESON_WHEEL_CROSSFILE
-Dsystem-freetype=true
"

clandro_step_pre_configure() {
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not available for on-device builds."
	fi

	# error: non-constant-expression cannot be narrowed from type 'unsigned int' to 'int' in initializer list [-Wc++11-narrowing]
	CXXFLAGS+=" -Wno-c++11-narrowing"
}

clandro_step_configure() {
	clandro_setup_meson

	cp -f $CLANDRO_MESON_CROSSFILE $CLANDRO_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[binaries\]\)$|\1\npython = '\'$(command -v python)\''|g' \
		$CLANDRO_MESON_WHEEL_CROSSFILE

	clandro_step_configure_meson
}

clandro_step_make() {
	pushd $CLANDRO_PKG_SRCDIR
	python -m build -w -n -x --config-setting builddir=$CLANDRO_PKG_BUILDDIR .
	popd
}

clandro_step_make_install() {
	local _pyv="${CLANDRO_PYTHON_VERSION/./}"
	local _whl="matplotlib-$CLANDRO_PKG_VERSION-cp$_pyv-cp$_pyv-android_$CLANDRO_ARCH.whl"
	pip install --no-deps --prefix=$CLANDRO_PREFIX --force-reinstall $CLANDRO_PKG_SRCDIR/dist/$_whl
}
