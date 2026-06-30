CLANDRO_PKG_HOMEPAGE=https://github.com/google/brotli
CLANDRO_PKG_DESCRIPTION="lossless compression algorithm and format (Python bindings)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/google/brotli/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=816c96e8e8f193b40151dad7e8ff37b1221d019dbcb9c35cd3fadbfe6477dfec
CLANDRO_PKG_DEPENDS="python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure() {
	# ERROR: ./lib/python3.12/site-packages/_brotli.cpython-312.so contains undefined symbols:
	# 31: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT   UND log2
	LDFLAGS+=" -lm"
	LDFLAGS+=" -Wl,--no-as-needed -lpython${CLANDRO_PYTHON_VERSION}"
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	pip install . --prefix="$CLANDRO_PREFIX" -vv --no-build-isolation --no-deps
}
