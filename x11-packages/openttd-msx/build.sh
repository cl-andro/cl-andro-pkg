CLANDRO_PKG_HOMEPAGE=https://bundles.openttdcoop.org/openmsx
CLANDRO_PKG_DESCRIPTION="Free music set for openttd"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.2
CLANDRO_PKG_SRCURL=https://cdn.openttd.org/openmsx-releases/$CLANDRO_PKG_VERSION/openmsx-$CLANDRO_PKG_VERSION-all.zip
CLANDRO_PKG_SHA256=5a4277a2e62d87f2952ea5020dc20fb2f6ffafdccf9913fbf35ad45ee30ec762
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_get_source() {
	clandro_download \
		"$CLANDRO_PKG_SRCURL" \
		"$CLANDRO_PKG_CACHEDIR/openmsx-$CLANDRO_PKG_VERSION.zip" \
		"$CLANDRO_PKG_SHA256"
	unzip -d "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PKG_CACHEDIR/openmsx-$CLANDRO_PKG_VERSION.zip"

	cd "$CLANDRO_PKG_SRCDIR"
	tar xf "openmsx-$CLANDRO_PKG_VERSION.tar" --strip-components=1
}

clandro_step_make_install() {
	install -d "$CLANDRO_PREFIX"/share/openttd/data
	install -m600 openmsx.obm "$CLANDRO_PREFIX"/share/openttd/data
	install -m600 *.mid "$CLANDRO_PREFIX"/share/openttd/data
}
