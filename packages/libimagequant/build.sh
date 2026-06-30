CLANDRO_PKG_HOMEPAGE=https://pngquant.org/lib/
CLANDRO_PKG_DESCRIPTION="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.4.1"
CLANDRO_PKG_SRCURL=https://github.com/ImageOptim/libimagequant/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2464a3e922b5a220b633d674062b82f0670114f8f3dd30d1935a621c95965f1b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/imagequant-sys"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	clandro_setup_rust
	clandro_setup_cargo_c
	cargo cinstall \
		--target $CARGO_TARGET_NAME \
		--prefix $CLANDRO_PREFIX \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES
}
