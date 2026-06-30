CLANDRO_PKG_HOMEPAGE=https://edbrowse.org/
CLANDRO_PKG_DESCRIPTION="Line based editor, browser, and mail client"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, MIT, CC0-1.0, curl"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.quickjs"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.16"
CLANDRO_PKG_SRCURL=https://github.com/edbrowse/edbrowse/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7593e7ebd4ab0cff05c8d1a6cfb72c667a62aaffa2d84e0d4d29b8ab68459d0e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libandroid-glob, libcurl, openssl, pcre2, quickjs-ng, readline, unixodbc"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-C src
PREFIX=$CLANDRO_PREFIX
QUICKJS_INCLUDE=$CLANDRO_PREFIX/include/quickjs
QUICKJS_LIB=$CLANDRO_PREFIX/lib/quickjs
"

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/LICENSE.quickjs ./
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
