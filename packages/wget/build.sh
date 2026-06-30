CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/wget/
CLANDRO_PKG_DESCRIPTION="Commandline tool for retrieving files using HTTP, HTTPS and FTP"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.25.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/wget/wget-${CLANDRO_PKG_VERSION}.tar.lz
CLANDRO_PKG_SHA256=19225cc756b0a088fc81148dc6a40a0c8f329af7fd8483f1c7b2fe50f4e08a1f
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv, libidn2, libuuid, openssl, pcre2, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_getpass=yes
ac_cv_libunistring=no
--enable-iri
--with-ssl=openssl
--with-included-libunistring=no
--without-libunistring-prefix
"
