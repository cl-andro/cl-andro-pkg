CLANDRO_PKG_HOMEPAGE=https://packages.debian.org/libapt-pkg-perl
CLANDRO_PKG_DESCRIPTION="Perl interface to APT's libapt-pkg"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.40"
CLANDRO_PKG_REVISION=14
CLANDRO_PKG_SRCURL="http://deb.debian.org/debian/pool/main/liba/libapt-pkg-perl/libapt-pkg-perl_${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=524d2ef77f3d6896c50e7674022d85e4a391a6a2b3c65ba5e50ac671fa7ce4a1
CLANDRO_PKG_DEPENDS="apt, libc++, perl"
CLANDRO_PKG_BUILD_IN_SRC=true


clandro_step_make() {
	local perl_version=$(. $CLANDRO_SCRIPTDIR/packages/perl/build.sh; echo $CLANDRO_PKG_VERSION)
	CFLAGS+=" -I$CLANDRO_PREFIX/lib/perl5/$perl_version/${CLANDRO_ARCH}-android/CORE \
		-I$CLANDRO_PREFIX/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
	LDFLAGS+=" -L$CLANDRO_PREFIX/lib/perl5/$perl_version/${CLANDRO_ARCH}-android/CORE \
		-L$CLANDRO_PREFIX/lib -lperl"
	perl Makefile.PL INSTALLDIRS=perl DESTDIR="$CLANDRO_PKG_MASSAGEDIR" \
		INSTALLMAN3DIR="$CLANDRO_PREFIX/share/man/man3" \
		LIB=$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android
	make CC="${CC}++" LD="${CC}++" OTHERLDFLAGS="$LDFLAGS" CCFLAGS="$CFLAGS"
}

clandro_step_post_massage() {
	local perl_version=$(. $CLANDRO_SCRIPTDIR/packages/perl/build.sh; echo $CLANDRO_PKG_VERSION)
	mv $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android/x86_64-linux-gnu-thread-multi/* \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android/
	rmdir $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android/x86_64-linux-gnu-thread-multi
}
