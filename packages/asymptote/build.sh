CLANDRO_PKG_HOMEPAGE=https://asymptote.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="A powerful descriptive vector graphics language for technical drawing"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.10"
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/asymptote/asymptote-${CLANDRO_PKG_VERSION}.src.tgz"
CLANDRO_PKG_SHA256=d27be8fef250d5dc338602bf723e1d09e8cd1e85c199ab4c80743089fd8cd2c7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fftw, libc++, libtirpc, zlib, ncurses, readline"
CLANDRO_PKG_BUILD_DEPENDS="glm"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gc
--disable-lsp
"

clandro_step_pre_configure() {
	rm -f CMakeLists.txt
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin asy
	cp -rT base $CLANDRO_PREFIX/share/asymptote
}
