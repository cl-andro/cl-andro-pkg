CLANDRO_PKG_HOMEPAGE=https://www.kernel.org/doc/man-pages/
CLANDRO_PKG_DESCRIPTION="Man pages for linux kernel and C library interfaces"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSES/Linux-man-pages-copyleft.txt, _man-pages-posix/POSIX-COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.18"
_POSIX_MANPAGE_VERSION="2017"
CLANDRO_PKG_SHA256=(
	c934fadc8b59748c68227a34f6581d2ddf8282b73cdcd52546c8cd88b74b24d1
	ce67bb25b5048b20dad772e405a83f4bc70faf051afa289361c81f9660318bc3
)
CLANDRO_PKG_SRCURL=(https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${CLANDRO_PKG_VERSION}.tar.xz
                   https://www.kernel.org/pub/linux/docs/man-pages/man-pages-posix/man-pages-posix-${_POSIX_MANPAGE_VERSION}-a.tar.xz)
CLANDRO_PKG_DEPENDS="mandoc"
CLANDRO_PKG_CONFLICTS="linux-man-pages"
CLANDRO_PKG_REPLACES="linux-man-pages"
CLANDRO_PKG_PROVIDES="linux-man-pages"
CLANDRO_PKG_EXTRA_MAKE_ARGS="-R prefix=$CLANDRO_PREFIX VERSION=$CLANDRO_PKG_VERSION"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

# Do not remove an entire section; intro should always be included.
# Bionic libc does not provide <aio.h>, <monetary.h> or pthread_cancel.
# man.7 and mdoc.7 is included with mandoc:
# getconf man page included with the getconf package:
# iconv-related manpages included with libiconv package:
CLANDRO_PKG_RM_AFTER_INSTALL="
share/man/man0p/aio.h.0p
share/man/man0p/monetary.h.0p
share/man/man1p/getconf.1p
share/man/man3/aio_*
share/man/man3/aiocb.3
share/man/man3/iconv.3
share/man/man3/iconv_close.3
share/man/man3/iconv_open.3
share/man/man3/pthread_*cancel*.3
share/man/man3p/aio_*
share/man/man3p/pthread_*cancel*.3p
share/man/man7/aio.7
share/man/man7/man.7
share/man/man7/mdoc.7
"

clandro_step_post_get_source() {
	mv man-pages-posix-${_POSIX_MANPAGE_VERSION} _man-pages-posix
}

clandro_step_make() {
	:
}

clandro_step_post_make_install() {
	# Bundle POSIX man pages in the same package:
	make -C _man-pages-posix install
}

clandro_step_post_massage() {
	local s
	for s in 1 8; do
		pushd share/man/man${s}
		find . -mindepth 1 -maxdepth 1 ! -name "intro.${s}.gz" \
				-exec rm -rf "{}" \;
		popd
	done
}
