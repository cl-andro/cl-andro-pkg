CLANDRO_PKG_HOMEPAGE=https://github.com/watchexec/watchexec
CLANDRO_PKG_DESCRIPTION="Executes commands in response to file modifications"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.1"
CLANDRO_PKG_SRCURL="https://github.com/watchexec/watchexec/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e54683eae585c7d3e47054eba9ff9e1e2327cdb3b705df0f96a9e66a0781ec5f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/notify-rust \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/notify-rust-bump-zbus.diff"
	local dir="vendor/notify-rust"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'notify-rust = { path = "./vendor/notify-rust" }' >> Cargo.toml
}

clandro_step_make_install() {
	cargo install \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--path crates/cli \
		--force \
		--locked \
		--no-track \
		--target $CARGO_TARGET_NAME \
		--root $CLANDRO_PREFIX \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_post_make_install() {
	local f
	install -Dm600 -t "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME" \
		"$CLANDRO_PKG_SRCDIR/doc/watchexec.1.md"
	install -Dm600 -t "$CLANDRO_PREFIX/share/man/man1" \
		"$CLANDRO_PKG_SRCDIR"/doc/watchexec.1
	install -Dm600 -T "completions/bash" \
		"$CLANDRO_PREFIX/share/bash-completion/completions/watchexec"
	install -Dm600 -T "completions/zsh" \
		"$CLANDRO_PREFIX/share/zsh/site-functions/_watchexec"
	install -Dm600 -T "completions/fish" \
		"$CLANDRO_PREFIX/share/fish/vendor_completions.d/watchexec.fish"
}
