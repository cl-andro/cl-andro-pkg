CLANDRO_PKG_HOMEPAGE=https://cscope.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A developers tool for browsing program code"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=15.9
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://fossies.org/linux/misc/cscope-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
hw_cv_func_snprintf_c99=yes
hw_cv_func_vsnprintf_c99=yes
--with-ncurses=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	export LEXLIB=""
}
