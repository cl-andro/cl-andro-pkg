CLANDRO_PKG_HOMEPAGE=https://metacpan.org/pod/Regexp::Assemble
CLANDRO_PKG_DESCRIPTION="Perl module to merge several regular expressions"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.38"
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL="https://salsa.debian.org/perl-team/modules/packages/libregexp-assemble-perl/-/archive/upstream/${CLANDRO_PKG_VERSION}/libregexp-assemble-perl-upstream-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=ca31b4111b825a4aa5262b07412822457910577881c2edb19407baad3997ebb0
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true


clandro_step_configure() {
	perl Makefile.PL
}

clandro_step_make_install() {
	local perl_version=$(. $CLANDRO_SCRIPTDIR/packages/perl/build.sh; echo $CLANDRO_PKG_VERSION)
	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/share/man/man3/
	cp $CLANDRO_PKG_SRCDIR/blib/man3/Regexp::Assemble.3pm \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/share/man/man3/

	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/Regexp/
	cp $CLANDRO_PKG_SRCDIR/lib/Regexp/Assemble.pm \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/Regexp/
}
