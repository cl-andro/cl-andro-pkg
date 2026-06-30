CLANDRO_PKG_HOMEPAGE=https://dev.openttdcoop.org/projects/opengfx
CLANDRO_PKG_DESCRIPTION="A free graphics set for openttd"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=7.1
CLANDRO_PKG_SRCURL=https://cdn.openttd.org/opengfx-releases/$CLANDRO_PKG_VERSION/opengfx-$CLANDRO_PKG_VERSION-all.zip
CLANDRO_PKG_SHA256=928fcf34efd0719a3560cbab6821d71ce686b6315e8825360fba87a7a94d7846
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_get_source() {
	clandro_download \
		"$CLANDRO_PKG_SRCURL" \
		"$CLANDRO_PKG_CACHEDIR/opengfx-$CLANDRO_PKG_VERSION.zip" \
		"$CLANDRO_PKG_SHA256"
	unzip -d "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PKG_CACHEDIR/opengfx-$CLANDRO_PKG_VERSION.zip"

	cd "$CLANDRO_PKG_SRCDIR"
	tar xf "opengfx-$CLANDRO_PKG_VERSION.tar" --strip-components=1
}

clandro_step_make_install() {
	install -d "$CLANDRO_PREFIX"/share/openttd/data
	install -m600 *.grf "$CLANDRO_PREFIX"/share/openttd/data
	install -m600 *.obg "$CLANDRO_PREFIX"/share/openttd/data
}
