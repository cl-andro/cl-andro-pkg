CLANDRO_PKG_HOMEPAGE=https://weechat.org/
CLANDRO_PKG_DESCRIPTION="Fast, light and extensible IRC chat client"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# `weechat-python-plugin` depends on libpython${CLANDRO_PYTHON_VERSION}.so.
# Please revbump and rebuild when bumping CLANDRO_PYTHON_VERSION.
CLANDRO_PKG_VERSION="4.7.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://www.weechat.org/files/src/weechat-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=e83fb71ca251c5dd74bd9c5a6bd3f85dc2eb8ecec0955f43c07f3e0911edb7d3
CLANDRO_PKG_DEPENDS="libandroid-support, libcurl, libgcrypt, libgnutls, libiconv, ncurses, zlib, zstd"
CLANDRO_PKG_BREAKS="weechat-dev"
CLANDRO_PKG_REPLACES="weechat-dev"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/weechat-curses
share/icons
share/man/man1/weechat-headless.1
"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DGETTEXT_FOUND=ON
-DENABLE_CJSON=OFF
-DENABLE_GUILE=OFF
-DENABLE_HEADLESS=OFF
-DENABLE_JAVASCRIPT=OFF
-DENABLE_LUA=ON
-DENABLE_MAN=ON
-DENABLE_PERL=ON
-DENABLE_PYTHON=ON
-DENABLE_PHP=OFF
-DENABLE_RUBY=ON
-DENABLE_SPELL=OFF
-DENABLE_TCL=OFF
-DENABLE_TESTS=OFF
-DMSGFMT_EXECUTABLE=$(command -v msgfmt)
-DMSGMERGE_EXECUTABLE=$(command -v msgmerge)
-DXGETTEXT_EXECUTABLE=$(command -v xgettext)
-DDL_LIBRARY=0
"

clandro_step_pre_configure() {
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPKG_CONFIG_EXECUTABLE=${PKG_CONFIG}"

	local _Ruby_API_VERSION=$(
		. $CLANDRO_SCRIPTDIR/packages/ruby/build.sh
		echo "$(echo $CLANDRO_PKG_VERSION | cut -d . -f 1-2).0"
	)
	local _Ruby_INCLUDE_DIR="$CLANDRO_PREFIX/include/ruby-$_Ruby_API_VERSION"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DRuby_INCLUDE_DIR=$_Ruby_INCLUDE_DIR"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DRuby_CONFIG_INCLUDE_DIR=$_Ruby_INCLUDE_DIR"
	if [ "$CLANDRO_ARCH" == "arm" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="/$CLANDRO_ARCH-linux-androideabi"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="/$CLANDRO_ARCH-linux-android"
	fi

	LDFLAGS+=" -ldl"
}
