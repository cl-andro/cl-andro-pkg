CLANDRO_PKG_HOMEPAGE=https://newsboat.org/
CLANDRO_PKG_DESCRIPTION="RSS/Atom feed reader for the text console"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.43"
CLANDRO_PKG_SRCURL=https://newsboat.org/releases/${CLANDRO_PKG_VERSION}/newsboat-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=325107b8a5fa4c432c9f85490dbf4fe61699d239fec161e34b3383345f7d37f5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="json-c, libandroid-glob, libandroid-support, libc++, libcurl, libiconv, libsqlite, libxml2, ncurses, stfl"
CLANDRO_PKG_BUILD_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
# CLANDRO_PKG_RM_AFTER_INSTALL="share/locale"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_bsd_main=no"
CLANDRO_PKG_CONFLICTS=newsbeuter
CLANDRO_PKG_REPLACES=newsbeuter

clandro_step_pre_configure() {
	clandro_setup_rust

	LDFLAGS+=" -liconv"

	export CXX_FOR_BUILD=g++
	export CXXFLAGS_FOR_BUILD="-O2"

	# Used by newsboat Makefile:
	export CARGO_BUILD_TARGET=$CARGO_TARGET_NAME
}
