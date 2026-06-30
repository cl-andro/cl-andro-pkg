CLANDRO_PKG_HOMEPAGE=https://subversion.apache.org
CLANDRO_PKG_DESCRIPTION="Centralized version control system characterized by its simplicity"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.apache.org/subversion/subversion-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=e78a29e7766b8b7b354497d08f71a55641abc53675ce1875584781aae35644a1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="apr, apr-util, serf, libexpat, libsqlite, liblz4, utf8proc, zlib"
CLANDRO_PKG_BREAKS="subversion-dev"
CLANDRO_PKG_REPLACES="subversion-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
svn_cv_pycfmt_apr_int64_t=UNUSED_REMOVE_AFTER_NEXT_UPDATE
--without-sasl
--without-libmagic
"

clandro_step_pre_configure() {
	CFLAGS+=" -std=c11 -I$CLANDRO_PREFIX/include/perl"
	LDFLAGS+=" -lm -Wl,--as-needed -L$CLANDRO_PREFIX/include/perl"
}

clandro_step_post_make_install() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES install-swig-pl-lib

	pushd subversion/bindings/swig/perl/native
	# it's probably not needed to pass all flags to both perl and make
	# but it works
	PERL_MM_USE_DEFAULT=1 INSTALLDIRS=site CC="$CC" LD="$CC" \
		OPTIMIZE="$CFLAGS" CFLAGS="$CFLAGS" CCFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS -lperl" LDDLFLAGS="-shared $CFLAGS $LDFLAGS -lperl" \
		INSTALLSITEMAN3DIR="$CLANDRO_PREFIX/share/man/man3" \
		perl Makefile.PL PREFIX="$CLANDRO_PREFIX"
	popd

	make -j $CLANDRO_PKG_MAKE_PROCESSES PREFIX="$CLANDRO_PREFIX" \
		PERL_MM_USE_DEFAULT=1 INSTALLDIRS=site CC="$CC" LD="$CC" \
		OPTIMIZE="$CFLAGS" CFLAGS="$CFLAGS" CCFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS -lperl" LDDLFLAGS="-shared $CFLAGS $LDFLAGS -lperl" \
		INSTALLSITEMAN3DIR="$CLANDRO_PREFIX/share/man/man3" \
		install-swig-pl

	local perl_version=$(. $CLANDRO_SCRIPTDIR/packages/perl/build.sh; echo $CLANDRO_PKG_VERSION)
	local host_perl_version=$(perl -e 'printf "%vd\n", $^V;')
	cd "$CLANDRO_PREFIX/lib"
	rm "x86_64-linux-gnu/perl/$host_perl_version/perllocal.pod"
	mkdir -p "perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android"
	mv "x86_64-linux-gnu/perl/$host_perl_version/"* \
		"perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android"
	rmdir x86_64-linux-gnu/{perl/{"$host_perl_version/",},}
}
