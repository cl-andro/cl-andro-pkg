CLANDRO_PKG_HOMEPAGE=https://bundles.openttdcoop.org/opensfx
CLANDRO_PKG_DESCRIPTION="Free sound set for openttd"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="license.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.3
CLANDRO_PKG_SRCURL=https://cdn.openttd.org/opensfx-releases/$CLANDRO_PKG_VERSION/opensfx-$CLANDRO_PKG_VERSION-all.zip
CLANDRO_PKG_SHA256=e0a218b7dd9438e701503b0f84c25a97c1c11b7c2f025323fb19d6db16ef3759
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_get_source() {
	clandro_download \
		"$CLANDRO_PKG_SRCURL" \
		"$CLANDRO_PKG_CACHEDIR/opensfx-$CLANDRO_PKG_VERSION.zip" \
		"$CLANDRO_PKG_SHA256"
	unzip -d "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PKG_CACHEDIR/opensfx-$CLANDRO_PKG_VERSION.zip"

	cd "$CLANDRO_PKG_SRCDIR"
	tar xf "opensfx-$CLANDRO_PKG_VERSION.tar" --strip-components=1
}

clandro_step_make_install() {
	install -d "$CLANDRO_PREFIX"/share/openttd/data
	install -m600 opensfx.* "$CLANDRO_PREFIX"/share/openttd/data
}
