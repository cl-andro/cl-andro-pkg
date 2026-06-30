CLANDRO_PKG_HOMEPAGE=https://taplo.tamasfe.dev/
CLANDRO_PKG_DESCRIPTION="A TOML LSP and toolkit"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.10.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tamasfe/taplo/archive/refs/tags/release-taplo-cli-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=eaec8435bfb5ccd89f7b4dd09385b6be25c2ff00aa25417cb82c88a59d4ccde0
CLANDRO_PKG_BUILD_DEPENDS='openssl'
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='release-taplo-cli-\d+\.\d+\.\d+'

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--release \
		--all-features
}

clandro_step_make_install() {
	install -Dm755 -t "$CLANDRO_PREFIX"/bin target/"$CARGO_TARGET_NAME"/release/taplo
	# shell completions
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	cargo run -- completions    zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	cargo run -- completions   bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	cargo run -- completions   fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	cargo run -- completions elvish > "${CLANDRO_PREFIX}/share/elvish/lib/${CLANDRO_PKG_NAME}.elv"
}
