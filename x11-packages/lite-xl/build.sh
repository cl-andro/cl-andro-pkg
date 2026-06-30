CLANDRO_PKG_HOMEPAGE=https://github.com/lite-xl/lite-xl
CLANDRO_PKG_DESCRIPTION="A lightweight text editor written in Lua"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1.8"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/lite-xl/lite-xl/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=fcaffb946bc60583369cb040d533a4ac18075a6d474d49a2a5ff4bf87e2e9a10
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, lua54, pcre2, sdl3"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Duse_system_lua=true
"
