CLANDRO_PKG_HOMEPAGE=http://www.xbill.org/
CLANDRO_PKG_DESCRIPTION="The classic game of Bill vs. PCs"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="README"
CLANDRO_PKG_MAINTAINER="@IntinteDAO"
CLANDRO_PKG_VERSION=2.1
CLANDRO_PKG_SRCURL=http://www.xbill.org/download/xbill-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=0efdfff1ce2df70b7a15601cb488cd7b2eb918d21d78e877bd773f112945608d
CLANDRO_PKG_DEPENDS="libx11, libxaw, libxmu, libxpm, libxt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-athena --disable-motif --disable-gtk"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_make_install() {
	install -Dm644 -t "${CLANDRO_PREFIX}/share/applications" "${CLANDRO_PKG_BUILDER_DIR}/xbill.desktop"
	install -Dm644 -t "${CLANDRO_PREFIX}/share/pixmaps" "${CLANDRO_PKG_BUILDER_DIR}/xbill.xpm"
}
