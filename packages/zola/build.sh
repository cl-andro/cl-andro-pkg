CLANDRO_PKG_HOMEPAGE=https://github.com/getzola/zola
CLANDRO_PKG_DESCRIPTION="A fast static site generator in a single binary with everything built-in."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.22.1"
CLANDRO_PKG_SRCURL="https://github.com/getzola/zola/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0f59479e05bce79e8d5860dc7e807ea818986094469ed8bf0bb46588ade95982
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	# clash with rust host build
	unset CFLAGS
}

clandro_step_make() {
	cargo build \
		--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--release
}

clandro_step_make_install() {
	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/zola "$CLANDRO_PREFIX"/bin
}

clandro_step_post_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	cargo run -- completion    zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	cargo run -- completion   bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	cargo run -- completion   fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	cargo run -- completion elvish > "${CLANDRO_PREFIX}/share/elvish/lib/${CLANDRO_PKG_NAME}.elv"
}
