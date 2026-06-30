CLANDRO_PKG_HOMEPAGE=https://github.com/libsdl-org/SDL_image
CLANDRO_PKG_DESCRIPTION="A simple library to load images of various formats as SDL surfaces (version 2)"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.12"
CLANDRO_PKG_SRCURL="https://github.com/libsdl-org/SDL_image/releases/download/release-${CLANDRO_PKG_VERSION}/SDL2_image-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=393f5efb50536ec13ca4f4affb69cc9966d3c3f969e6c5e701faddf9f9785381
# Prevent updating to SDL3 version
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libavif, libjpeg-turbo, libjxl, libpng, libtiff, libwebp, sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
# "disable shared" in sdl2-image means "disable dynamic loading in favor of dynamic linking"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-stb-image
--disable-jpg-shared
--disable-jxl-shared
--disable-png-shared
--disable-tif-shared
--disable-webp-shared
--disable-avif-shared
"
