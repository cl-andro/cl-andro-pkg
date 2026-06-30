CLANDRO_PKG_HOMEPAGE=https://docs.astral.sh/uv/
CLANDRO_PKG_DESCRIPTION="An extremely fast Python package installer and resolver, written in Rust."
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.12"
CLANDRO_PKG_SRCURL=https://github.com/astral-sh/uv/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b535e471fcf0e343687a51e6f9935104eae19d6a328ad75d17e1b280ee8efb95
CLANDRO_PKG_DEPENDS="zstd"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_rust
}

clandro_step_make() {
	PKG_CONFIG_ALL_DYNAMIC=1 \
	ZSTD_SYS_USE_PKG_CONFIG=1 \
	cargo build --jobs "${CLANDRO_PKG_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin target/"${CARGO_TARGET_NAME}"/release/uv
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin target/"${CARGO_TARGET_NAME}"/release/uvx
}

clandro_step_post_make_install() {
	# Make a placeholder for shell-completions (to be filled with postinst)
	mkdir -p "${CLANDRO_PREFIX}"/share/bash-completion/completions
	mkdir -p "${CLANDRO_PREFIX}"/share/elvish/lib
	mkdir -p "${CLANDRO_PREFIX}"/share/fish/vendor_completions.d
	mkdir -p "${CLANDRO_PREFIX}"/share/zsh/site-functions
	touch "${CLANDRO_PREFIX}"/share/bash-completion/completions/uv
	touch "${CLANDRO_PREFIX}"/share/elvish/lib/uv.elv
	touch "${CLANDRO_PREFIX}"/share/fish/vendor_completions.d/uv.fish
	touch "${CLANDRO_PREFIX}"/share/zsh/site-functions/_uv
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh

		uv generate-shell-completion bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/uv"
		uv generate-shell-completion elvish > "$CLANDRO_PREFIX/share/elvish/lib/uv.elv"
		uv generate-shell-completion fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/uv.fish"
		uv generate-shell-completion zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_uv"
	EOF
}
