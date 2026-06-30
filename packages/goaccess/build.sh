CLANDRO_PKG_HOMEPAGE=https://goaccess.io
CLANDRO_PKG_DESCRIPTION="An open source real-time web log analyzer and interactive viewer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.2"
CLANDRO_PKG_SRCURL=https://tar.goaccess.io/goaccess-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b9b7484a413279863c7d92dc7dd4c19dcb55c0a2d138735efc18570bcc4eaa0e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses, openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-utf8
--with-openssl"
