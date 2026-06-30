CLANDRO_PKG_HOMEPAGE="https://github.com/bootandy/dust"
CLANDRO_PKG_DESCRIPTION="A more intuitive version of du in rust"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.4"
CLANDRO_PKG_SRCURL=https://github.com/bootandy/dust/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2f6768534bd01727234e67f1dd3754c9547aa18c715f6ee52094e881ebac50e3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm644 "completions/${CLANDRO_PKG_NAME}.bash" "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	install -Dm644 "completions/${CLANDRO_PKG_NAME}.fish" "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	install -Dm644 "completions/_${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	install -Dm644 "man-page/${CLANDRO_PKG_NAME}.1" "${CLANDRO_PREFIX}/share/man/man1/${CLANDRO_PKG_NAME}.1"
}
