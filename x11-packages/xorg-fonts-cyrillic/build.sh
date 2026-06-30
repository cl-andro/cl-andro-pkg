CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.org cyrillic fonts"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.4"
# the ones with other versions just have to be like that because they don't have a version 1.0.4
CLANDRO_PKG_SRCURL=("https://xorg.freedesktop.org/releases/individual/font/font-cronyx-cyrillic-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-misc-cyrillic-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-screen-cyrillic-1.0.5.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-winitzki-cyrillic-${CLANDRO_PKG_VERSION}.tar.xz")
CLANDRO_PKG_SHA256=(dc0781ce0dcbffdbf6aae1a00173a13403f92b0de925bca5a9e117e4e2d6b789
					76021a7f53064001914a57fd08efae57f76b68f0a24dca8ab1b245474ee8e993
					8f758bb8cd580c7e655487d1d0db69d319acae54d932b295d96d9d9b83fde5c0
					3b6d82122dc14776e3afcd877833a7834e1f900c53fc1c7bb2d67c781cfa97a8)
CLANDRO_PKG_LICENSE_FILE="
font-cronyx-cyrillic-$CLANDRO_PKG_VERSION/COPYING
font-misc-cyrillic-$CLANDRO_PKG_VERSION/COPYING
font-screen-cyrillic-1.0.5/COPYING
font-winitzki-cyrillic-$CLANDRO_PKG_VERSION/COPYING
"
CLANDRO_PKG_DEPENDS="fontconfig-utils, xorg-font-util, xorg-fonts-alias, xorg-fonts-encodings, xorg-mkfontscale"
CLANDRO_PKG_CONFLICTS="xorg-fonts-lite"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	local i
	for i in {0..3}; do
		clandro_download "${CLANDRO_PKG_SRCURL[i]}" "$(basename "${CLANDRO_PKG_SRCURL[i]}")" "${CLANDRO_PKG_SHA256[i]}"
		tar xf "$(basename "${CLANDRO_PKG_SRCURL[i]}")" -C "${CLANDRO_PKG_SRCDIR}"
	done
}

clandro_step_make_install() {
	local i
	for i in {0..3}; do
		local file=$(basename "${CLANDRO_PKG_SRCURL[i]}")
		local dir="${CLANDRO_PKG_SRCDIR}/${file%%.tar.*}"

		pushd "${dir}"
		./configure \
			--prefix="${CLANDRO_PREFIX}" \
			--host="${CLANDRO_HOST_PLATFORM}" \
			--with-fontdir="${CLANDRO_PREFIX}/share/fonts/cyrillic"
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
		popd
	done
}

clandro_step_post_massage() {
	rm -f share/fonts/cyrillic/fonts.*
}
