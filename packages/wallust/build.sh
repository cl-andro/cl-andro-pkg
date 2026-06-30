CLANDRO_PKG_HOMEPAGE=https://explosion-mental.codeberg.page/wallust
CLANDRO_PKG_DESCRIPTION="Generate colors from an image"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.2"
CLANDRO_PKG_SRCURL="https://codeberg.org/explosion-mental/wallust/archive/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=46c2592217f0de968437850b14b2e844f2af4158b70135b2b448dc426c0309a1
CLANDRO_PKG_RECOMMENDS="imagemagick"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
	export CLANDRO_PKG_EXTRA_MAKE_ARGS="
		CARGO=$(command -v cargo)
	"

	# prevents "gcc: error: unrecognized command-line option '-mfpu=neon'" when targeting 32-bit
	unset CFLAGS
}
