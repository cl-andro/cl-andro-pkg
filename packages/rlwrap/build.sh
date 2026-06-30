CLANDRO_PKG_HOMEPAGE=https://github.com/hanslub42/rlwrap
CLANDRO_PKG_DESCRIPTION="Wrapper using readline to enable editing of keyboard input for commands"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.48"
CLANDRO_PKG_SRCURL=https://github.com/hanslub42/rlwrap/releases/download/v${CLANDRO_PKG_VERSION}/rlwrap-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cdf69074a216a8284574dddd145dd046c904ad5330a616e0eed53c9043f2ecbc
CLANDRO_PKG_DEPENDS="ncurses, readline"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-libptytty
ac_cv_func_grantpt=yes
ac_cv_func_unlockpt=yes
ac_cv_lib_util_openpty=no
ptyttylib_cv_ptys=STREAMS
"

clandro_step_pre_configure() {
	autoreconf -vfi
}
