CLANDRO_PKG_HOMEPAGE=http://www.gnu.org/software/libmicrohttpd/
CLANDRO_PKG_DESCRIPTION="A small C library that is supposed to make it easy to run an HTTP server as part of another application"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.5"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libmicrohttpd/libmicrohttpd-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b46d00f58efa6f497b97d2e782c4ee66301d412ddd855dd3068518b3a2cd3ea2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgnutls"
CLANDRO_PKG_BREAKS="libmicrohttpd-dev"
CLANDRO_PKG_REPLACES="libmicrohttpd-dev"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-examples
--enable-curl
--enable-https
--enable-largefile
--enable-messages"
