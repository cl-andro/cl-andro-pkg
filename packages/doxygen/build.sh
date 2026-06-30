CLANDRO_PKG_HOMEPAGE=http://www.doxygen.org
CLANDRO_PKG_DESCRIPTION="A documentation system for C++, C, Java, IDL and PHP"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.17.0"
CLANDRO_PKG_SRCURL="https://github.com/doxygen/doxygen/archive/refs/tags/Release_${CLANDRO_PKG_VERSION//./_}.tar.gz"
CLANDRO_PKG_SHA256=28199ea88989fc56e302c927ef979596fe9247dd231e767ba6edcdbaa49f78aa
CLANDRO_PKG_DEPENDS="libc++, libiconv"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DCMAKE_BUILD_TYPE=Release
-DFLEX_EXECUTABLE=$(command -v flex)
-DPYTHON_EXECUTABLE=$(command -v python3)
-Dbuild_parse=yes
-Dbuild_xmlparser=yes
"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+_\d+_\d+"
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/share/man/man1
	cp "$CLANDRO_PKG_SRCDIR"/doc/doxygen.1 "$CLANDRO_PREFIX"/share/man/man1
}
