CLANDRO_PKG_HOMEPAGE=https://contourpy.readthedocs.io/
CLANDRO_PKG_DESCRIPTION="Python library for calculating contours in 2D quadrilateral grids"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.3"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://github.com/contourpy/contourpy
CLANDRO_PKG_DEPENDS="python, python-numpy, python-pip"
CLANDRO_PKG_BUILD_DEPENDS="pybind11"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, meson-python, build"
_NUMPY_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/python-numpy/build.sh; echo $CLANDRO_PKG_VERSION)
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="'numpy==$_NUMPY_VERSION'"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_MESON_WHEEL_CROSSFILE="$CLANDRO_PKG_TMPDIR/wheel-cross-file.txt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cross-file $CLANDRO_MESON_WHEEL_CROSSFILE
"

clandro_step_configure() {
	clandro_setup_meson

	cp -f $CLANDRO_MESON_CROSSFILE $CLANDRO_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[binaries\]\)$|\1\npython = '\'$(command -v python)\''|g' \
		$CLANDRO_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[properties\]\)$|\1\nnumpy-include-dir = '\'$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include\''|g' \
		$CLANDRO_MESON_WHEEL_CROSSFILE

	clandro_step_configure_meson
}

clandro_step_make() {
	pushd $CLANDRO_PKG_SRCDIR
	PYTHONPATH= python -m build -w -n -x --config-setting builddir=$CLANDRO_PKG_BUILDDIR .
	popd
}

clandro_step_make_install() {
	local _pyv="${CLANDRO_PYTHON_VERSION/./}"
	local _whl="contourpy-$CLANDRO_PKG_VERSION-cp$_pyv-cp$_pyv-android_$CLANDRO_ARCH.whl"
	pip install --force-reinstall --no-deps --prefix=$CLANDRO_PREFIX $CLANDRO_PKG_SRCDIR/dist/$_whl
}
