CLANDRO_PKG_HOMEPAGE=https://www.tcl.tk/
CLANDRO_PKG_DESCRIPTION="Powerful but easy to learn dynamic programming language"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="license.terms"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.6.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/tcl/Tcl/${CLANDRO_PKG_VERSION}/tcl${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=5880225babf7954c58d4fb0f5cf6279104ce1cd6aa9b71e9a6322540e1c4de66
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_BREAKS="tcl-dev, tcl-static"
CLANDRO_PKG_REPLACES="tcl-dev, tcl-static"
CLANDRO_PKG_NO_STATICSPLIT=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memcmp_working=yes
ac_cv_func_memcmp=yes
ac_cv_func_strtod=yes
ac_cv_func_strtoul=yes
tcl_cv_strstr_unbroken=ok
tcl_cv_strtod_buggy=ok
tcl_cv_strtod_unbroken=ok
tcl_cv_strtoul_unbroken=ok
--disable-rpath
--enable-man-symlinks
--mandir=$CLANDRO_PREFIX/share/man
"

clandro_step_pre_configure() {
	rm -rf $CLANDRO_PKG_SRCDIR/pkgs/sqlite3* # libsqlite-tcl is a separate package
	CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR/unix
	CFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
}

clandro_step_post_make_install() {
	# expect needs private headers
	make install-private-headers
	local _MAJOR_VERSION=${CLANDRO_PKG_VERSION:0:3}
	cd $CLANDRO_PREFIX/bin
	ln -f -s tclsh$_MAJOR_VERSION tclsh

	# Needed to install $CLANDRO_PKG_LICENSE_FILE.
	CLANDRO_PKG_SRCDIR=$(dirname "$CLANDRO_PKG_SRCDIR")

	#avoid conflict with perl
	mv $CLANDRO_PREFIX/share/man/man3/Thread.3 $CLANDRO_PREFIX/share/man/man3/Tcl_Thread.3
}
