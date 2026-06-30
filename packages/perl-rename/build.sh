CLANDRO_PKG_HOMEPAGE=https://search.cpan.org/~pederst/rename/
CLANDRO_PKG_DESCRIPTION="renames multiple files using perl expressions."
CLANDRO_PKG_LICENSE="Artistic-License-2.0, GPL-2.0" # https://metacpan.org/pod/Software::License::Perl_5
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.14
CLANDRO_PKG_SRCURL=https://cpan.metacpan.org/authors/id/P/PE/PEDERST/rename-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4d19e5cb8fb09fe35e6df69ae07132cf621b0b2a82f54149091bce630642adbd
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$CLANDRO_PREFIX
INSTALLSITEMAN1DIR=$CLANDRO_PREFIX/share/man/man1
INSTALLSITEMAN3DIR=$CLANDRO_PREFIX/share/man/man3
"

clandro_step_configure() {
	perl Makefile.PL $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_post_massage() {
	find $CLANDRO_PKG_MASSAGEDIR -type f -name "rename*" -execdir sh -c 'mv {} $(echo {} | sed "s|rename|perl-rename|")' \;
	rm -rf $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/x86_64-linux-gnu
}
