CLANDRO_PKG_HOMEPAGE=https://dejavu-fonts.github.io/
CLANDRO_PKG_DESCRIPTION="Font family based on the Bitstream Vera Fonts with a wider range of characters"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.37
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/dejavu/dejavu/${CLANDRO_PKG_VERSION}/dejavu-fonts-ttf-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=fa9ca4d13871dd122f61258a80d01751d603b4d3ee14095d65453b4e846e17d7
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_CONFFILES="
etc/fonts/conf.d/20-unhint-small-dejavu-sans-mono.conf
etc/fonts/conf.d/20-unhint-small-dejavu-sans.conf
etc/fonts/conf.d/20-unhint-small-dejavu-serif.conf
etc/fonts/conf.d/57-dejavu-sans-mono.conf
etc/fonts/conf.d/57-dejavu-sans.conf
etc/fonts/conf.d/57-dejavu-serif.conf
"

clandro_step_make_install() {
	## Install fonts.
	mkdir -p "${CLANDRO_PREFIX}/share/fonts/TTF"
	cp -f ttf/*.ttf "${CLANDRO_PREFIX}/share/fonts/TTF/"

	## Install config files used by 'fontconfig' package.
	mkdir -p "${CLANDRO_PREFIX}/etc/fonts/conf.d"
	cp -f fontconfig/*.conf "${CLANDRO_PREFIX}/etc/fonts/conf.d/"
}
