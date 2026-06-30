CLANDRO_PKG_HOMEPAGE=http://www.clisp.org/
CLANDRO_PKG_DESCRIPTION="GNU CLISP - an ANSI Common Lisp Implementation"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.49
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/project/clisp/clisp/${CLANDRO_PKG_VERSION}/clisp-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256="8132ff353afaa70e6b19367a25ae3d5a43627279c25647c220641fed00f8e890"
CLANDRO_PKG_DEPENDS="readline, libandroid-support"
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_configure() {
	cd $CLANDRO_PKG_BUILDDIR

	export XCPPFLAGS="$CPPFLAGS"
	export XCFLAGS="$CFLAGS"
	export XLDFLAGS="$LDFLAGS"

	unset CC
	unset CPPFLAGS
	unset CFLAGS
	unset LDFLAGS

	$CLANDRO_PKG_SRCDIR/configure \
		--host=$CLANDRO_HOST_PLATFORM \
		--prefix=$CLANDRO_PREFIX \
		--enable-shared \
		--disable-static \
		--srcdir=$CLANDRO_PKG_SRCDIR \
		--ignore-absence-of-libsigsegv \
		ac_cv_func_select=yes
}
