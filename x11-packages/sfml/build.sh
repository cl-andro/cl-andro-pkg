CLANDRO_PKG_HOMEPAGE=https://www.sfml-dev.org/
CLANDRO_PKG_DESCRIPTION="A simple, fast, cross-platform and object-oriented multimedia API"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.0"
CLANDRO_PKG_SRCURL=https://github.com/SFML/SFML/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=91209a112c2bd0bc6f4ce0d5f3e413cfb48b57c0de59f5507dc81f71b1ad7a5c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, harfbuzz, libc++, libflac, libogg, libresolv-wrapper, libssh2, libvorbis, libx11, libxcursor, libxi, libxrandr, mbedtls, openal-soft, opengl"
# -DBUILD_SHARED_LIBS=ON is required to prevent this error when importing SFML using CMake:
# Requested SFML configuration (Shared) was not found
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DSFML_USE_SYSTEM_DEPS=ON
"

clandro_step_post_get_source() {
	cp src/SFML/Window/Android/JoystickImpl.{cpp,hpp} src/SFML/Window/Unix/
}
