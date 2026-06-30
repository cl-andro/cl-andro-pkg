CLANDRO_PKG_HOMEPAGE=https://kid3.kde.org/
CLANDRO_PKG_DESCRIPTION="Efficient ID3 tag editor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.9.7"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/kid3/kid3-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=392aafb176cc8dc9fdf08364f9bb754913725447b8f3e0e581c1d96c2fc30ae4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libchromaprint, ffmpeg, id3lib, libc++, libflac, libogg, libvorbis, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia, readline, taglib"
CLANDRO_PKG_BUILD_DEPENDS="docbook-xsl, qt6-qtbase-cross-tools, qt6-qtdeclarative-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_TERMUX=OFF
-DBUILD_WITH_QT6=ON
-DWITH_APPS=Qt;CLI
-DWITH_FFMPEG=ON
"

clandro_step_post_get_source() {
	# I don't want to make a patch for this:
	find . -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_TERMUX/g'
}

clandro_step_pre_configure() {
	local DOCBOOK_XSL_VER=$(bash -c ". $CLANDRO_SCRIPTDIR/packages/docbook-xsl/build.sh; echo \$CLANDRO_PKG_VERSION")
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DWITH_DOCBOOKDIR=$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-${DOCBOOK_XSL_VER}"

	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/kid3"
}
