CLANDRO_PKG_HOMEPAGE=https://www.jetbrains.com/lp/mono/
CLANDRO_PKG_DESCRIPTION="A free and open-source typeface for developers"
CLANDRO_PKG_LICENSE="OFL-1.1"
CLANDRO_PKG_LICENSE_FILE="OFL.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.304
CLANDRO_PKG_SRCURL=https://github.com/JetBrains/JetBrainsMono/releases/download/v$CLANDRO_PKG_VERSION/JetBrainsMono-$CLANDRO_PKG_VERSION.zip
CLANDRO_PKG_SHA256=6f6376c6ed2960ea8a963cd7387ec9d76e3f629125bc33d1fdcd7eb7012f7bbf
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

# The original "clandro_extract_src_archive" always strips away fonts/webfonts
# but the fonts we want are in fonts/ttf
clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "$CLANDRO_PKG_SRCURL")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	unzip -q "$file" -d "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	## Install fonts.
	mkdir -p "$CLANDRO_PREFIX/share/fonts/TTF"
	cp fonts/ttf/*.ttf "$CLANDRO_PREFIX/share/fonts/TTF/"
}
