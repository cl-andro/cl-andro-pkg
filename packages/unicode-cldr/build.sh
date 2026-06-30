CLANDRO_PKG_HOMEPAGE=http://cldr.unicode.org/
CLANDRO_PKG_DESCRIPTION="Unicode Common Locale Data Repository"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="48.1"
CLANDRO_PKG_SRCURL="https://unicode.org/Public/cldr/$CLANDRO_PKG_VERSION/cldr-common-$CLANDRO_PKG_VERSION.zip"
CLANDRO_PKG_SHA256=c691e94f217486fed259871429ae71cc4855e8a7f22b1586eb6eb52262c9c307
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

# Extract like libncnn
clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "$CLANDRO_PKG_SRCURL")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	unzip -q "$file" -d "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	install -dm755 "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME"
	cp -Rf "$CLANDRO_PKG_SRCDIR"/common/* "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/"
}
