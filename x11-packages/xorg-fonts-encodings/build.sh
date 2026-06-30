CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.org font encoding files"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.0"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/font/encodings-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9ff13c621756cfa12e95f32ba48a5b23839e8f577d0048beda66c67dab4de975
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-fontrootdir=$CLANDRO_PREFIX/share/fonts"

clandro_step_pre_configure() {
	## Checking only for mkfontdir which is a part of xfonts-utils that provides
	## tool mkfontscale used in further steps.
	if [ -z "$(command -v mkfontdir)" ]; then
		echo
		echo "Command 'mkfontdir' is not found."
		echo "Install it by running 'sudo apt install xfonts-utils'."
		echo
		exit 1
	fi
}

clandro_step_post_make_install() {
	cd "${CLANDRO_PREFIX}"/share/fonts/encodings/large
	mkfontscale -b -s -l -n -r -p "${CLANDRO_PREFIX}"/share/fonts/encodings/large -e . .

	cd "${CLANDRO_PREFIX}"/share/fonts/encodings/
	mkfontscale -b -s -l -n -r -p "${CLANDRO_PREFIX}"/share/fonts/encodings -e . -e large .
}
