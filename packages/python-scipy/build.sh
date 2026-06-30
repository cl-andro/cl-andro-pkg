CLANDRO_PKG_HOMEPAGE=https://scipy.org/
CLANDRO_PKG_DESCRIPTION="Fundamental algorithms for scientific computing in Python"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.17.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/scipy/scipy
CLANDRO_PKG_DEPENDS="libc++, libopenblas, python, python-numpy, python-pip"
CLANDRO_PKG_BUILD_DEPENDS="python-numpy-static, pybind11"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, 'Cython>=3.0.8', meson-python, build"
_NUMPY_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/python-numpy/build.sh; echo $CLANDRO_PKG_VERSION)
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="pythran, 'numpy==$_NUMPY_VERSION'"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

CLANDRO_MESON_WHEEL_CROSSFILE="$CLANDRO_PKG_TMPDIR/wheel-cross-file.txt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dfortran_std=none
-Dblas=openblas
-Dlapack=openblas
-Duse-pythran=true
--cross-file $CLANDRO_MESON_WHEEL_CROSSFILE
"

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/
"

clandro_step_pre_configure() {
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not available for on-device builds."
	fi

	clandro_setup_flang

	# Use a wrapper FC
	mkdir -p $CLANDRO_PKG_TMPDIR/_fake_bin
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@COMPILER@|$(command -v ${FC})|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/wrapper.py.in \
		> $CLANDRO_PKG_TMPDIR/_fake_bin/"$(basename ${FC})"
	chmod +x $CLANDRO_PKG_TMPDIR/_fake_bin/"$(basename ${FC})"
	export PATH="$CLANDRO_PKG_TMPDIR/_fake_bin:$PATH"
}

clandro_step_configure() {
	clandro_setup_meson

	cp -f $CLANDRO_MESON_CROSSFILE $CLANDRO_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[binaries\]\)$|\1\npython = '\'$(command -v python)\''|g' \
		$CLANDRO_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[properties\]\)$|\1\nnumpy-include-dir = '\'$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include\''|g' \
		$CLANDRO_MESON_WHEEL_CROSSFILE

	(unset PYTHONPATH && clandro_step_configure_meson)
}

clandro_step_make() {
	pushd $CLANDRO_PKG_SRCDIR
	PYTHONPATH= python -m build -w -n -x --config-setting builddir=$CLANDRO_PKG_BUILDDIR .
	popd
}

clandro_step_make_install() {
	local _pyv="${CLANDRO_PYTHON_VERSION/./}"
	local _whl="scipy-$CLANDRO_PKG_VERSION-cp$_pyv-cp$_pyv-android_$CLANDRO_ARCH.whl"
	pip install --force-reinstall --no-deps --prefix=$CLANDRO_PREFIX $CLANDRO_PKG_SRCDIR/dist/$_whl
}
