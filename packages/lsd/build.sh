CLANDRO_PKG_HOMEPAGE=https://github.com/lsd-rs/lsd
CLANDRO_PKG_DESCRIPTION="Next gen ls command"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_SRCURL=https://github.com/lsd-rs/lsd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dae8d43087686a4a1de0584922608e9cbab00727d0f72e4aa487860a9cbfeefa
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	export SHELL_COMPLETIONS_DIR=completions
}

clandro_step_post_make_install() {
	install -Dm644 "completions/${CLANDRO_PKG_NAME}.bash" "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	install -Dm644 "completions/${CLANDRO_PKG_NAME}.fish" "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	install -Dm644 "completions/_${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
}
