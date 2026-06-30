CLANDRO_PKG_HOMEPAGE=https://ice-wm.org/
CLANDRO_PKG_DESCRIPTION="Window manager with goals of speed, simplicity, and usability"
CLANDRO_PKG_LICENSE="LGPL-2.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.0"
CLANDRO_PKG_SRCURL="https://github.com/ice-wm/icewm/releases/download/$CLANDRO_PKG_VERSION/icewm-$CLANDRO_PKG_VERSION.tar.lz"
CLANDRO_PKG_SHA256=b8b22a2f0460c51f92ba785102bd122707966a618bb872c95fa6e6801d620cd1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="alsa-lib, imlib2, libandroid-glob, libandroid-wordexp, libice, librsvg, libsm, libsndfile, libxcomposite, libxcursor, libxdamage, libxinerama, libxrandr, libxres, xdg-utils"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs"
CLANDRO_PKG_SUGGESTS="xdg-menu"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
		patch="$CLANDRO_PKG_BUILDER_DIR/genpref.diff"
		echo "Applying patch: $(basename "$patch")"
		patch --silent -p1 < "$patch"
	fi

	LDFLAGS+=" -landroid-glob -landroid-wordexp"

	# Every instance of '/usr' in the code is replaceable with '$CLANDRO_PREFIX'.
	# Every instance of 'xdg-open' in the code is replaceable with 'xdg-utils-xdg-open'.
	find "$CLANDRO_PKG_SRCDIR" -type f | \
		xargs -n 1 sed -i \
		-e "s|/usr|$CLANDRO_PREFIX|g" \
		-e "s|/etc|$CLANDRO_PREFIX/etc|g" \
		-e "s|xdg-open|xdg-utils-xdg-open|g"
}
