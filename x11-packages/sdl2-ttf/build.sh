CLANDRO_PKG_HOMEPAGE=https://github.com/libsdl-org/SDL_ttf
CLANDRO_PKG_DESCRIPTION="A library that allows you to use TrueType fonts in your SDL applications (version 2)"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.24.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/libsdl-org/SDL_ttf/releases/download/release-${CLANDRO_PKG_VERSION}/SDL2_ttf-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0b2bf1e7b6568adbdbc9bb924643f79d9dedafe061fa1ed687d1d9ac4e453bfd
# Prevent updating to 3.x.x version
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="freetype, opengl, sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-freetype-builtin
--disable-harfbuzz
"
