CLANDRO_PKG_HOMEPAGE=https://codeberg.org/newsraft/newsraft
CLANDRO_PKG_DESCRIPTION="Newsraft is a feed reader with text-based user interface"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.36"
CLANDRO_PKG_SRCURL=https://codeberg.org/newsraft/newsraft/archive/newsraft-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=769dce748a4de741f1888eb199f71aeb41068b8527e0d5779fe0eb51fbbd72e3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="curl, gumbo-parser, libexpat, libsqlite"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	make install EXAMPLES_DIR="$CLANDRO_PREFIX/share/doc/${CLANDRO_PKG_NAME}/example"
	make install-desktop
	install -Dm644 doc/changes.md "${CLANDRO_PREFIX}/share/doc/${CLANDRO_PKG_NAME}/changes.md"
}

clandro_step_install_license() {
	for FILE in "${CLANDRO_PKG_SRCDIR}"/doc/license*; do
		cp -f "$FILE" "${CLANDRO_PREFIX}/share/doc/${CLANDRO_PKG_NAME}/"
	done
}
