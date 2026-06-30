CLANDRO_PKG_HOMEPAGE=https://github.com/rakitzis/rc
CLANDRO_PKG_DESCRIPTION="An alternative implementation of the plan 9 rc shell"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.7.4
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/rakitzis/rc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0b83f8698dd8ef44ca97b25c4748c087133f53c7fff39b6b70dab65931def8b0
CLANDRO_PKG_DEPENDS="readline"
CLANDRO_PKG_BREAKS="rcshell"
CLANDRO_PKG_REPLACES="rcshell"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setpgrp_void=yes
rc_cv_sysv_sigcld=no
"

clandro_step_host_build() {
	(cd $CLANDRO_PKG_SRCDIR && autoreconf -vfi)
	$CLANDRO_PKG_SRCDIR/configure
	make mksignal mkstatval
}

clandro_step_pre_configure() {
	autoreconf -vfi
	cp $CLANDRO_PKG_HOSTBUILD_DIR/{mksignal,mkstatval} $CLANDRO_PKG_BUILDDIR/
	touch -d 'next hour' $CLANDRO_PKG_BUILDDIR/{mksignal,mkstatval}
}
