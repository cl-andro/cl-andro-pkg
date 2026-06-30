CLANDRO_PKG_HOMEPAGE=http://cowlark.com/wordgrinder/
CLANDRO_PKG_DESCRIPTION="A Unicode-aware character cell word processor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="licenses/COPYING.Lua, licenses/COPYING.LuaBitOp, licenses/COPYING.LuaFileSystem, licenses/COPYING.Minizip, licenses/COPYING.Scowl, licenses/COPYING.uthash, licenses/COPYING.wcwidth, licenses/COPYING.WordGrinder, licenses/COPYING.xpattern"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/davidgiven/wordgrinder/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=856cbed2b4ccd5127f61c4997a30e642d414247970f69932f25b4b5a81b18d3f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
CLANDRO_PKG_DEPENDS="lua53, ncurses, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_ninja

	# Missing and causes install failure.
	touch licenses/COPYING.LuaFileSystem

	make CC=gcc OBJDIR="$PWD/build" "$PWD"/build/lua
	make OBJDIR="$PWD/build" LUA_PACKAGE=lua53
}

clandro_step_make_install() {
	install -Dm700 \
		"$CLANDRO_PKG_SRCDIR"/bin/wordgrinder-lua53-curses-release \
		"$CLANDRO_PREFIX"/bin/wordgrinder
	install -Dm600 \
		"$CLANDRO_PKG_SRCDIR"/bin/wordgrinder.1 \
		"$CLANDRO_PREFIX"/share/man/man1/
}
