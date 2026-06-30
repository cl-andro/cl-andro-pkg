CLANDRO_PKG_HOMEPAGE=https://github.com/chrisstaite/lameenc
CLANDRO_PKG_DESCRIPTION="Python bindings around the LAME encoder"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.2"
CLANDRO_PKG_SRCURL=https://github.com/chrisstaite/lameenc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=87a941abc2f7773a2bf6fea4e49ed0eb3c5be78b1110733322f1ddc413a6dbcb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libmp3lame, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, setuptools-scm, wheel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	rm -rf build dist CMakeLists.txt
}

clandro_step_make() {
	# Set version for setuptools_scm
	export SETUPTOOLS_SCM_PRETEND_VERSION="${CLANDRO_PKG_VERSION}"

	cross-python -m build -w -x -o build \
		-C="--build-option=--libdir=$CLANDRO_PREFIX/lib" \
		-C="--build-option=--incdir=$CLANDRO_PREFIX/include/lame"
}

clandro_step_make_install() {
	local _pyv="${CLANDRO_PYTHON_VERSION/./}"
	local _whl="lameenc-$CLANDRO_PKG_VERSION-cp$_pyv-cp$_pyv-android_$CLANDRO_ARCH.whl"

	cross-pip install --no-deps --prefix=$CLANDRO_PREFIX --force-reinstall $CLANDRO_PKG_SRCDIR/build/$_whl
}
