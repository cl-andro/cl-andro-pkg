CLANDRO_PKG_HOMEPAGE=https://github.com/facebook/pyrefly.git
CLANDRO_PKG_DESCRIPTION="A fast type checker and language server for Python"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@AhmadNaruto"
CLANDRO_PKG_VERSION="0.64.1"
CLANDRO_PKG_SRCURL="https://github.com/facebook/pyrefly/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f9f3c9dfb2d47f968628f0c1bf128e83352ecb3137215ba84953edd4db95d877
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/cc \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/rust-cc-do-not-concatenate-all-the-CFLAGS.diff"
	local dir="vendor/cc"
	echo "Applying patch: $patch"
	test -f "$patch"
	patch -p1 -d "$dir" < "$patch"

	sed -i '/\[patch.crates-io\]/a cc = { path = "./vendor/cc" }' Cargo.toml
}

clandro_step_make() {
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/pyrefly"
}
