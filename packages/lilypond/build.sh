CLANDRO_PKG_HOMEPAGE=https://lilypond.org/
CLANDRO_PKG_DESCRIPTION="A music engraving program"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSE, LICENSE.OFL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.26.0"
CLANDRO_PKG_SRCURL="https://lilypond.org/download/sources/v${CLANDRO_PKG_VERSION%.*}/lilypond-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=bbe82dbeba7f7f99ddcd8d1fa134a0d89cafa6e8f815fde5bb01f4208b06fe05
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, ghostscript, glib, guile, harfbuzz, libc++, pango, python, tex-gyre"
CLANDRO_PKG_BUILD_DEPENDS="flex"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-documentation
GUILE_FLAVOR=guile-3.0
PYTHON=python${CLANDRO_PYTHON_VERSION}
"

clandro_step_post_make_install() {
	pushd $CLANDRO_PREFIX/share/lilypond
	local dst
	for dst in $(find . -type f -name "texgyre*.otf"); do
		local src="$CLANDRO_PREFIX/share/fonts/tex-gyre/$(basename "$dst")"
		if [ -e "$src" ]; then
			ln -sf "$src" "$dst"
		fi
	done
	popd
}
