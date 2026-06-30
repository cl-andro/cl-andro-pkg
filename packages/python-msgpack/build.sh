CLANDRO_PKG_HOMEPAGE=https://github.com/msgpack/msgpack-python
CLANDRO_PKG_DESCRIPTION="MessagePack serializer implementation for Python"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.2"
CLANDRO_PKG_REVISION=2
# _cmsgpack.c is absent in https://github.com/msgpack/msgpack-python/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SRCURL=https://pypi.org/packages/source/m/msgpack/msgpack-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3b60763c1373dd60f398488069bcdc703cd08a711477b5d480eecc9f9626f47e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, Cython, setuptools, wheel"

clandro_step_make() {
	PYTHONPATH='' python -m build -w -n -x "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	local _pyver="${CLANDRO_PYTHON_VERSION//./}"
	local _wheel="msgpack-${CLANDRO_PKG_VERSION}-cp${_pyver}-cp${_pyver}-android_${CLANDRO_ARCH}.whl"
	pip install --no-deps --prefix="$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR/dist/${_wheel}"
}
