CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.org 100dpi fonts"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.4
_FONT_ADOBE_UTOPIA_VERSION=${CLANDRO_PKG_VERSION%.*}.$((${CLANDRO_PKG_VERSION##*.}+1))
CLANDRO_PKG_SRCURL=(https://xorg.freedesktop.org/releases/individual/font/font-adobe-100dpi-${CLANDRO_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-adobe-utopia-100dpi-${_FONT_ADOBE_UTOPIA_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-100dpi-${CLANDRO_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-lucidatypewriter-100dpi-${CLANDRO_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bitstream-100dpi-${CLANDRO_PKG_VERSION}.tar.xz)
CLANDRO_PKG_SHA256=(b67aff445e056328d53f9732d39884f55dd8d303fc25af3dbba33a8ba35a9ccf
                   fb84ec297a906973548ca59b7c6daeaad21244bec5d3fb1e7c93df5ef43b024b
                   fd8f5efe8491faabdd2744808d3d4eafdae5c83e617017c7fddd2716d049ab1e
                   76ec09eda4094a29d47b91cf59c3eba229c8f7d1ca6bae2abbb3f925e33de8f2
                   2d1cc682efe4f7ebdf5fbd88961d8ca32b2729968728633dea20a1627690c1a7)
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
			--with-fontdir="${CLANDRO_PREFIX}/share/fonts/100dpi"
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
		popd
	done
}

clandro_step_post_massage() {
	rm -f share/fonts/100dpi/fonts.*
}

clandro_step_install_license() {
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		$CLANDRO_PKG_BUILDER_DIR/COPYING
}
