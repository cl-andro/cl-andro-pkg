CLANDRO_PKG_HOMEPAGE=https://dvdauthor.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Generates a DVD-Video movie from a valid MPEG-2 stream"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/dvdauthor/dvdauthor-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3020a92de9f78eb36f48b6f22d5a001c47107826634a785a62dfcd080f612eb7
CLANDRO_PKG_DEPENDS="fontconfig, freetype, fribidi, graphicsmagick, libdvdread, libpng, libxml2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_MAGICKCONFIG=GraphicsMagick-config
"
