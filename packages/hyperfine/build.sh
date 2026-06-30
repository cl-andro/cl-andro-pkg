CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/hyperfine
CLANDRO_PKG_DESCRIPTION="A command-line benchmarking tool"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.20.0"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/hyperfine/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f90c3b096af568438be7da52336784635a962c9822f10f98e5ad11ae8c7f5c64
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	# Manpages.
	install -Dm600 doc/"${CLANDRO_PKG_NAME}".1 \
		"${CLANDRO_PREFIX}"/share/man/man1/"${CLANDRO_PKG_NAME}".1

	# Shell completions.
	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${CLANDRO_PKG_NAME}"*/out/"${CLANDRO_PKG_NAME}".bash \
		"${CLANDRO_PREFIX}"/share/bash-completion/completions/"${CLANDRO_PKG_NAME}".bash

	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${CLANDRO_PKG_NAME}"*/out/"${CLANDRO_PKG_NAME}".fish \
		"${CLANDRO_PREFIX}"/share/fish/vendor_completions.d/"${CLANDRO_PKG_NAME}".fish

	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${CLANDRO_PKG_NAME}"*/out/_"${CLANDRO_PKG_NAME}" \
		"${CLANDRO_PREFIX}"/share/zsh/site-functions/_"${CLANDRO_PKG_NAME}"
}
