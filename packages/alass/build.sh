CLANDRO_PKG_HOMEPAGE=https://github.com/kaegi/alass
CLANDRO_PKG_DESCRIPTION="Automatic Language-Agnostic Subtitle Synchronization"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/kaegi/alass/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=ce88f92c7a427b623edcabb1b64e80be70cca2777f3da4b96702820a6cdf1e26
CLANDRO_PKG_DEPENDS="ffmpeg"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	rm -f Makefile
}

clandro_step_make_install() {
	clandro_setup_rust
	cargo install \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--path alass-cli \
		--force \
		--locked \
		--target $CARGO_TARGET_NAME \
		--root $CLANDRO_PREFIX \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	# https://github.com/rust-lang/cargo/issues/3316:
	rm -f $CLANDRO_PREFIX/.crates.toml
	rm -f $CLANDRO_PREFIX/.crates2.json
}

clandro_step_post_make_install() {
	install -Dm644 LICENSE "$CLANDRO_PREFIX/share/licenses/alass/LICENSE"
}
