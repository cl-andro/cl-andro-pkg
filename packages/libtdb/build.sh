CLANDRO_PKG_HOMEPAGE=https://tdb.samba.org/
CLANDRO_PKG_DESCRIPTION="A trivial database system"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.15"
CLANDRO_PKG_SRCURL=https://samba.org/ftp/tdb/tdb-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fba09d8df1f1b9072aeae8e78b2bd43c5afef20b2f6deefa633aa14a377a8dd2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbsd"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cross-compile
--cross-answers cross-answers.txt
--disable-python
"

clandro_step_pre_configure() {
	sed 's:@CLANDRO_ARCH@:'$CLANDRO_ARCH':g' \
		$CLANDRO_PKG_BUILDER_DIR/cross-answers.txt > cross-answers.txt
}

clandro_step_configure() {
	./configure \
		--prefix=$CLANDRO_PREFIX \
		--host=$CLANDRO_HOST_PLATFORM \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}
