CLANDRO_PKG_HOMEPAGE=https://www.duktape.org/
CLANDRO_PKG_DESCRIPTION="An embeddable Javascript engine with a focus on portability and compact footprint"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.7.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/svaarala/duktape/releases/download/v$CLANDRO_PKG_VERSION/duktape-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=90f8d2fa8b5567c6899830ddef2c03f3c27960b11aca222fa17aa7ac613c2890
CLANDRO_PKG_REPLACES="duktape (<< 2.3.0-1), libduktape-dev"
CLANDRO_PKG_BREAKS="duktape (<< 2.3.0-1), libduktape-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	# Add missing NEEDED on libm.so
	sed -i 's/duktape\.c/& -lm/' Makefile.sharedlibrary

	make -f Makefile.sharedlibrary CC="${CC}" GXX="${CXX}" INSTALL_PREFIX="${CLANDRO_PREFIX}" install

	make -f Makefile.cmdline CC="${CC}" GXX="${CXX}" INSTALL_PREFIX="${CLANDRO_PREFIX}" duk

	install duk "${CLANDRO_PREFIX}"/bin
}
