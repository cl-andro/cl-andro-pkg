CLANDRO_PKG_HOMEPAGE="https://github.com/n-t-roff/sc"
CLANDRO_PKG_DESCRIPTION="A vi-like spreadsheet calculator"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.16-1.2.0"
CLANDRO_PKG_SRCURL=https://github.com/n-t-roff/sc/archive/refs/tags/${CLANDRO_PKG_VERSION/-/_}.tar.gz
CLANDRO_PKG_SHA256=c53285a6a6f30d37e0bab21563e3e2c5c01ee62da63efeb2219029cde1c01ace
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
# n-t-roff-sc is a maintained fork of sc and thus replaces the original
CLANDRO_PKG_CONFLICTS="sc"
CLANDRO_PKG_REPLACES="sc"
CLANDRO_PKG_PROVIDES="sc"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/_/-/"

clandro_step_post_configure () {
	CFLAGS+=" -I$CLANDRO_PREFIX/include"
	sed -i "s|prefix=/usr/local|prefix=$CLANDRO_PREFIX|g" Makefile
}
