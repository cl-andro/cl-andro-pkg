CLANDRO_PKG_HOMEPAGE=https://github.com/matthiaskrgr/cargo-cache
CLANDRO_PKG_DESCRIPTION="Tool to manage cargo cache"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.3"
CLANDRO_PKG_SRCURL="https://github.com/matthiaskrgr/cargo-cache/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=d0f71214d17657a27e26aef6acf491bc9e760432a9bc15f2571338fcc24800e4
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/libgit2-sys \
		-exec rm -rf '{}' \;

	patch --silent -p1 \
		-d vendor/libgit2-sys \
		< "$CLANDRO_PKG_BUILDER_DIR/libgit2-sys-getloadavg.diff"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'libgit2-sys = { path = "./vendor/libgit2-sys" }' >> Cargo.toml
}

clandro_step_make() {
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/$CARGO_TARGET_NAME/release/$CLANDRO_PKG_NAME"
}
