CLANDRO_PKG_HOMEPAGE=https://www.nerdfonts.com/
CLANDRO_PKG_DESCRIPTION="Symbols-only font containing the Nerd Font icons"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.4.0
CLANDRO_PKG_SRCURL=https://github.com/ryanoasis/nerd-fonts/releases/download/v$CLANDRO_PKG_VERSION/NerdFontsSymbolsOnly.zip
CLANDRO_PKG_SHA256=8e617904b980fe3648a4b116808788fe50c99d2d495376cb7c0badbd8a564c47
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="
etc/fonts/conf.d/10-nerd-font-symbols.conf
"

# The original "clandro_extract_src_archive" always strips the first components
# but the source of font files is directly under the root directory of the zip file
clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "$CLANDRO_PKG_SRCURL")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	unzip -q "$file" -d "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	## Install fonts.
	mkdir -p "$CLANDRO_PREFIX/share/fonts/TTF"
	cp -f *.ttf "$CLANDRO_PREFIX/share/fonts/TTF/"

	## Install config files used by 'fontconfig' package.
	mkdir -p "$CLANDRO_PREFIX/etc/fonts/conf.d"
	cp -f *.conf "$CLANDRO_PREFIX/etc/fonts/conf.d/"
}
