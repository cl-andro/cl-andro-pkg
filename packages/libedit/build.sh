CLANDRO_PKG_HOMEPAGE=https://thrysoee.dk/editline/
CLANDRO_PKG_DESCRIPTION="Library providing line editing, history, and tokenization functions"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=20240517-3.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://thrysoee.dk/editline/libedit-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3a489097bb4115495f3bd85ae782852b7097c556d9500088d74b6fa38dbd12ff
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BREAKS="libedit-dev"
CLANDRO_PKG_REPLACES="libedit-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="share/man/man7/editline.7 share/man/man3/history.3"

clandro_step_pre_configure() {
	CFLAGS+=" -D__STDC_ISO_10646__=201103L -DNBBY=CHAR_BIT"
}
