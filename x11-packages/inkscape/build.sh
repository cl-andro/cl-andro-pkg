CLANDRO_PKG_HOMEPAGE=https://inkscape.org/
CLANDRO_PKG_DESCRIPTION="Free and open source vector graphics editor"
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-2.0-or-later, GPL-3.0, GPL-3.0-or-later, LGPL-2.1, LGPL-2.1-or-later, LGPL-3.0, LGPL-3.0-or-later, Mozilla-1.1, OFL-1.1"
CLANDRO_PKG_LICENSE_FILE="
LICENSES/GPL-2.0.txt,
LICENSES/GPL-2.0-or-later.txt,
LICENSES/GPL-3.0.txt,
LICENSES/GPL-3.0-or-later.txt,
LICENSES/LGPL-2.1.txt,
LICENSES/LGPL-2.1-or-later.txt,
LICENSES/LGPL-3.0.txt,
LICENSES/LGPL-3.0-or-later.txt,
LICENSES/MPL-1.1.txt,
LICENSES/OFL-1.1.txt
"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.4"
CLANDRO_PKG_SRCURL="https://media.inkscape.org/dl/resources/file/inkscape-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=bbce5753a1e08b871a5cf16c665eb060700aaab9a6a379dc63f4c4d9b3b8856e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, double-conversion, fontconfig, freetype, gdk-pixbuf, glib, gsl, gspell, gtk3, gtkmm3, gtksourceview4, harfbuzz, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libgc, libglibmm-2.4, libiconv, libjasper, libjpeg-turbo, libpangomm-1.4, libpng, libsigc++-2.0, libx11, libxml2, libxslt, littlecms, pango, poppler, potrace, readline, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, graphicsmagick-static"
CLANDRO_PKG_RECOMMENDS="inkscape-extensions, inkscape-tutorials"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_IMAGE_MAGICK=OFF
-DWITH_LIBCDR=OFF
-DWITH_LIBVISIO=OFF
-DWITH_LIBWPG=OFF
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DCMS_NO_REGISTER_KEYWORD -I${CLANDRO_PREFIX}/include/libxml2 -include libxml/xmlmemory.h"
	LDFLAGS+=" -fopenmp -static-openmp -Wl,-rpath=$CLANDRO_PREFIX/lib/inkscape"
}
