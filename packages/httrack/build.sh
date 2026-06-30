CLANDRO_PKG_HOMEPAGE=http://www.httrack.com
CLANDRO_PKG_DESCRIPTION="It allows you to download a World Wide Web site from the Internet"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.49.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/h/httrack/httrack_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=2d2ddfe8d1264024862abe801819e177ecbb1eb417dcf4650a054c671f3b7ff9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="httrack-data, libandroid-execinfo, libiconv, openssl, zlib"
CLANDRO_PKG_BREAKS="httrack-dev"
CLANDRO_PKG_REPLACES="httrack-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--docdir=$CLANDRO_PREFIX/share/httrack/html
--with-zlib=$CLANDRO_PREFIX
LIBS=-liconv
"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_configure() {
	make clean
}
