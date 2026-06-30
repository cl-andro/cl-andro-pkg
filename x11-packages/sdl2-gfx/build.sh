CLANDRO_PKG_HOMEPAGE=https://www.ferzkopp.net/joomla/content/view/19/14/
CLANDRO_PKG_DESCRIPTION="Graphics primitives and surface functions for SDL2"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.4"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=63e0e01addedc9df2f85b93a248f06e8a04affa014a835c2ea34bfe34e576262
CLANDRO_PKG_DEPENDS="sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-mmx
"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}
