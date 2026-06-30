CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.org 75dpi fonts"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.4
_FONT_ADOBE_UTOPIA_VERSION=${CLANDRO_PKG_VERSION%.*}.$((${CLANDRO_PKG_VERSION##*.}+1))
CLANDRO_PKG_SRCURL=(https://xorg.freedesktop.org/releases/individual/font/font-adobe-75dpi-${CLANDRO_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-adobe-utopia-75dpi-${_FONT_ADOBE_UTOPIA_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-75dpi-${CLANDRO_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-lucidatypewriter-75dpi-${CLANDRO_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bitstream-75dpi-${CLANDRO_PKG_VERSION}.tar.xz)
CLANDRO_PKG_SHA256=(1281a62dbeded169e495cae1a5b487e1f336f2b4d971d92911c59c103999b911
                   a726245932d0724fa0c538c992811d63d597e5f53928f4048e9caf5623797760
                   6026d8c073563dd3cbb4878d0076eed970debabd21423b3b61dd90441b9e7cda
                   864e2c39ac61f04f693fc2c8aaaed24b298c2cd40283cec12eee459c5635e8f5
                   aaeb34d87424a9c2b0cf0e8590704c90cb5b42c6a3b6a0ef9e4676ef773bf826)
CLANDRO_PKG_DEPENDS="fontconfig-utils, xorg-font-util, xorg-fonts-alias, xorg-fonts-encodings, xorg-mkfontscale"
CLANDRO_PKG_CONFLICTS="xorg-fonts-lite"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	local i
	for i in {0..4}; do
		clandro_download "${CLANDRO_PKG_SRCURL[i]}" "$(basename "${CLANDRO_PKG_SRCURL[i]}")" "${CLANDRO_PKG_SHA256[i]}"
		tar xf "$(basename "${CLANDRO_PKG_SRCURL[i]}")" -C "${CLANDRO_PKG_SRCDIR}"
	done
}

clandro_step_make_install() {
	local i
	for i in {0..4}; do
		local file=$(basename "${CLANDRO_PKG_SRCURL[i]}")
		local dir="${CLANDRO_PKG_SRCDIR}/${file%%.tar.*}"

		pushd "${dir}"
		./configure \
			--prefix="${CLANDRO_PREFIX}" \
			--host="${CLANDRO_HOST_PLATFORM}" \
			--with-fontdir="${CLANDRO_PREFIX}/share/fonts/75dpi"
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
		popd
	done
}

clandro_step_post_massage() {
	rm -f share/fonts/75dpi/fonts.*
}

clandro_step_install_license() {
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		$CLANDRO_PKG_BUILDER_DIR/COPYING
}
