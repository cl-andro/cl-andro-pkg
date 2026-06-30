CLANDRO_PKG_HOMEPAGE=https://gitlab.com/gnuwget/wget2
CLANDRO_PKG_DESCRIPTION="The successor of GNU Wget, a file and recursive website downloader"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.2.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://mirrors.kernel.org/gnu/wget/wget2-${CLANDRO_PKG_VERSION}.tar.lz"
CLANDRO_PKG_SHA256=f77397cce50b60670f48cfca5867517caed93f7c07ebea76541984d5d8d5c6d1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="brotli, gpgme, libandroid-glob, openssl, libiconv, libidn2, libnghttp2, pcre2, zlib, zstd"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
--with-ssl=openssl
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
}
