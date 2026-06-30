CLANDRO_PKG_HOMEPAGE=https://github.com/bootchk/resynthesizer
CLANDRO_PKG_DESCRIPTION="Suite of gimp plugins for texture synthesis"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.1"
CLANDRO_PKG_SRCURL="https://github.com/bootchk/resynthesizer/archive/refs/tags/v${CLANDRO_PKG_VERSION%.*}.tar.gz"
CLANDRO_PKG_SHA256=d0f459e551d428e3cd3fec4c3ebfe448e6e2947d9b24553373308d6d41ddd580
CLANDRO_PKG_DEPENDS="gimp, python"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_meson
	clandro_setup_cmake
}

clandro_step_configure() {
	mkdir -p build
	$CLANDRO_MESON setup build \
		--prefix="$CLANDRO_PREFIX" \
		--buildtype=release \
		--cross-file="$CLANDRO_MESON_CROSSFILE"
}

clandro_step_make() {
	ninja -C build
}

clandro_step_make_install() {
	ninja -C build install
}
