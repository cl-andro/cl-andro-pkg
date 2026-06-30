CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Create an index of scalable font files for X"
CLANDRO_PKG_LICENSE="MIT, HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.4"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/app/mkfontscale-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a01492a17a9b6c0ee3f92ee578850e305315b9f298da5f006a1cd4b51db01a5e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="findutils, freetype, libfontenc, zlib"
CLANDRO_PKG_BUILD_DEPENDS="xorg-util-macros, xorgproto"
CLANDRO_PKG_CONFLICTS="xorg-mkfontdir"
CLANDRO_PKG_REPLACES="xorg-mkfontdir"

clandro_step_create_debscripts() {
	for i in postinst postrm triggers; do
		cp "${CLANDRO_PKG_BUILDER_DIR}/${i}" ./${i}
		sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" ./${i}
	done
	unset i
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
}
