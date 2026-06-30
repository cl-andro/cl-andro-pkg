CLANDRO_PKG_HOMEPAGE=https://codeberg.org/ravachol/kew
CLANDRO_PKG_DESCRIPTION="Music for the Shell"
CLANDRO_PKG_LICENSE="GPL-2.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://codeberg.org/ravachol/kew/archive/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=746236a57c96f9e74e88557f1d9d9e62cad53a2e140596bb9acb051cf59118b5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="chafa, faad2, fftw, glib, libogg, libvorbis, libopus, opusfile, taglib"
CLANDRO_PKG_SUGGESTS="chroma-visualizer"
CLANDRO_PKG_EXTRA_MAKE_ARGS="ARCH=$CLANDRO_ARCH"

clandro_step_post_get_source() {
	local original_prefix_component_one="/data/data/com."
	local original_prefix_component_two="termux/files/usr"
	local original_prefix="${original_prefix_component_one}${original_prefix_component_two}"
	find "$CLANDRO_PKG_SRCDIR" -type f | \
		xargs -n 1 sed -i -e "s%${original_prefix}%\@HARDCODED_TERMUX_PREFIX\@%g"
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		CLANDRO_PKG_EXTRA_MAKE_ARGS+=" DEBUG=1"
	fi
}
