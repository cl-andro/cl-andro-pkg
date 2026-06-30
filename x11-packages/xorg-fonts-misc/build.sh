CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.org misc fonts"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.4"
# the ones with other versions just have to be like that because they don't have a version 1.0.4
CLANDRO_PKG_SRCURL=("https://xorg.freedesktop.org/releases/individual/font/font-arabic-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-cursor-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-daewoo-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-dec-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-isas-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-jis-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-micro-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-misc-ethiopic-1.0.5.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-misc-meltho-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-misc-misc-1.1.3.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-mutt-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-schumacher-misc-1.1.3.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-sony-misc-${CLANDRO_PKG_VERSION}.tar.xz"
					"https://xorg.freedesktop.org/releases/individual/font/font-sun-misc-${CLANDRO_PKG_VERSION}.tar.xz")
CLANDRO_PKG_SHA256=(46ffe61b52c78a1d2dca70ff20a9f2d84d69744639cab9a085c7a7ee17663467
					25d9c9595013cb8ca08420509993a6434c917e53ca1fec3f63acd45a19d4f982
					f63c8b3dc8f30098cb868b7db2c2c0c8b5b3fd2cefd044035697a43d4c7a4f31
					82d968201d8ff8bec0e51dccd781bb4d4ebf17e11004944279bdc0201e161af7
					47e595bbe6da444b9f6fcaa26539abc7ba1989e23afa6cdc49e22e484cc438fc
					78d1eff6c471f7aa6802a26d62cccf51d8e5185586406d9b6e1ee691b0bffad0
					2ee0b9d6bd7ae849aff1bd82efab44a1b6b368fbb5e11d12ff7f015a3df6f943
					4749a7e6e1a1eef6c91fcc9a04e8b1c0ed027d40c1599e5a6c93270d8469b612
					63be5ec17078898f263c24096a68b43ae5b06b88852e42549afa03d124d65219
					79abe361f58bb21ade9f565898e486300ce1cc621d5285bec26e14b6a8618fed
					b12359f4e12c23bcfcb448b918297e975fa91bef5293d88d3c25343cc768bb24
					8b849f0cdb1e55a34cc3dd8b0fb37443fabbc224d5ba44085569581244a68070
					e6b09f823fccb06e0bd0b2062283b6514153323bd8a7486e9c2e3f55ab84946b
					dd84dd116d927affa4fa0fa29727b3ecfc0f064238817c0a1e552a0ac384db9f)
CLANDRO_PKG_LICENSE_FILE="
font-arabic-misc-${CLANDRO_PKG_VERSION}/COPYING
font-cursor-misc-${CLANDRO_PKG_VERSION}/COPYING
font-daewoo-misc-${CLANDRO_PKG_VERSION}/COPYING
font-dec-misc-${CLANDRO_PKG_VERSION}/COPYING
font-isas-misc-${CLANDRO_PKG_VERSION}/COPYING
font-jis-misc-${CLANDRO_PKG_VERSION}/COPYING
font-micro-misc-${CLANDRO_PKG_VERSION}/COPYING
font-misc-ethiopic-1.0.5/COPYING
font-misc-meltho-${CLANDRO_PKG_VERSION}/COPYING
font-misc-misc-1.1.3/COPYING
font-mutt-misc-${CLANDRO_PKG_VERSION}/COPYING
font-schumacher-misc-1.1.3/COPYING
font-sony-misc-${CLANDRO_PKG_VERSION}/COPYING
font-sun-misc-${CLANDRO_PKG_VERSION}/COPYING
"
CLANDRO_PKG_DEPENDS="fontconfig-utils, xorg-font-util, xorg-fonts-alias, xorg-fonts-encodings, xorg-mkfontscale"
CLANDRO_PKG_CONFLICTS="xorg-fonts-lite"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	local i
	for i in {0..13}; do
		clandro_download "${CLANDRO_PKG_SRCURL[i]}" "$(basename "${CLANDRO_PKG_SRCURL[i]}")" "${CLANDRO_PKG_SHA256[i]}"
		tar xf "$(basename "${CLANDRO_PKG_SRCURL[i]}")" -C "${CLANDRO_PKG_SRCDIR}"
	done
}

clandro_step_make_install() {
	local i
	for i in {0..13}; do
		local file=$(basename "${CLANDRO_PKG_SRCURL[i]}")
		local dir="${CLANDRO_PKG_SRCDIR}/${file%%.tar.*}"

		pushd "${dir}"
		./configure \
			--prefix="${CLANDRO_PREFIX}" \
			--host="${CLANDRO_HOST_PLATFORM}" \
			--with-fontdir="${CLANDRO_PREFIX}/share/fonts/misc"
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
		popd
	done
}

clandro_step_post_massage() {
	rm -f share/fonts/misc/fonts.*
}
