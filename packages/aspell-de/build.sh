CLANDRO_PKG_HOMEPAGE=http://aspell.net/
CLANDRO_PKG_DESCRIPTION="German dictionary for aspell"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:20161207.7.0"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/aspell/dict/de/aspell6-de-$(sed 's/\./-/g' <<< ${CLANDRO_PKG_VERSION:2}).tar.bz2
CLANDRO_PKG_SHA256=c2125d1fafb1d4effbe6c88d4e9127db59da9ed92639c7cbaeae1b7337655571
CLANDRO_PKG_DEPENDS="aspell"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_configure() {
	cd ${CLANDRO_PKG_SRCDIR}
	sed -i 's#^dictdir=.*#dictdir='${CLANDRO_PREFIX}'/lib/aspell-0.60#' configure
	sed -i 's#^datadir=.*#datadir='${CLANDRO_PREFIX}'/lib/aspell-0.60#' configure
	./configure
}

clandro_step_make() {
	make
}

clandro_step_make_install() {
	make install
	echo "add de_CH.multi" > "${CLANDRO_PREFIX}/lib/aspell-0.60/swiss.alias"
}
