CLANDRO_PKG_HOMEPAGE=https://wiki.debian.org/apt-file
CLANDRO_PKG_DESCRIPTION="search for files within packages"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.3
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/a/apt-file/apt-file_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2ab7109340054f0073c690d62d055c31bf69e1f50fb65b080bbf0d4ae572dae7
CLANDRO_PKG_DEPENDS="apt, libapt-pkg-perl, libregexp-assemble-perl, perl"
CLANDRO_PKG_REPLACES="whatprovides"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="DESTDIR=$CLANDRO_PREFIX BINDIR=$CLANDRO_PREFIX/bin \
				MANDIR=$CLANDRO_PREFIX/share/man/man1"


clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/bash_completion.d/
	cp $CLANDRO_PKG_SRCDIR/debian/bash-completion \
		$CLANDRO_PREFIX/etc/bash_completion.d/apt-file
}
