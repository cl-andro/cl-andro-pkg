CLANDRO_PKG_HOMEPAGE=https://myriad-dreamin.github.io/tinymist
CLANDRO_PKG_DESCRIPTION="An integrated language service for Typst"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.14.10"
CLANDRO_PKG_SRCURL=https://github.com/Myriad-Dreamin/tinymist/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=215c08d8a10ff51e15711f0684eafc85d119dc98db57f4f47ec7bf5987ea681e
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BREAKS="typst-lsp"
CLANDRO_PKG_REPLACES="typst-lsp"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+'


clandro_step_pre_configure() {
	# We're not shipping the VS Code plugin
	rm -rf .vscode
	clandro_setup_rust
	unset CFLAGS # clash with rust host build

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME
	export OPENSSL_NO_VENDOR=1
	export PKG_CONFIG_ALL_DYNAMIC=1

	cargo fetch --locked --target "$CARGO_TARGET_NAME"
}

clandro_step_make() {
	cargo build \
		--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" target/"${CARGO_TARGET_NAME}"/release/tinymist

	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/nushell/vendor/autoload"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	cargo run --bin tinymist -- completion     zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_tinymist"
	cargo run --bin tinymist -- completion    bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/tinymist"
	cargo run --bin tinymist -- completion    fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/tinymist.fish"
	cargo run --bin tinymist -- completion  elvish > "${CLANDRO_PREFIX}/share/elvish/lib/tinymist.elv"
	cargo run --bin tinymist -- completion nushell > "${CLANDRO_PREFIX}/share/nushell/vendor/autoload/tinymist.nu"
	# there are currently no completions for typlite
	# and despite `clap_mangen` being present there is currently no manpages
}
