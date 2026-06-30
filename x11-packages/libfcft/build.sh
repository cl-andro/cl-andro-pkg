CLANDRO_PKG_HOMEPAGE=https://codeberg.org/dnkl/fcft
CLANDRO_PKG_DESCRIPTION="A small font loading and glyph rasterization library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://codeberg.org/dnkl/fcft/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f18bf79562e06d41741690cd1e07a02eb2600ae39eb5752eef8a698f603a482c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, harfbuzz, libpixman, utf8proc"
CLANDRO_PKG_BUILD_DEPENDS="libtllist, scdoc"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=enabled
"
