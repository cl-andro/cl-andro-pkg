CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/oleo/
CLANDRO_PKG_DESCRIPTION="The GNU Spreadsheet"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.99.16"
CLANDRO_PKG_REVISION=10
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/oleo/oleo-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=6598df85d06ff2534ec08ed0657508f17dbbc58dd02d419160989de7c487bc86
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-x --infodir=$CLANDRO_PREFIX/share/info"
CLANDRO_PKG_KEEP_INFOPAGES=true

CLANDRO_PKG_RM_AFTER_INSTALL="
Oleo/*
share/oleo/oleo.html"

clandro_step_pre_configure() {
	# configure script tries to build program which writes `sizeof` expression
	# result with our toolchain and tries to execute it which is impossible
	# with cross-compiling inside docker.
	export ac_cv_sizeof_short=__SIZEOF_SHORT__
	export ac_cv_sizeof_int=__SIZEOF_INT__
	export ac_cv_sizeof_long=__SIZEOF_LONG__
	export ac_cv_header_stdc=yes

	export CFLAGS+=" -fcommon"
}
