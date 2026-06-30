CLANDRO_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
CLANDRO_PKG_DESCRIPTION="Search tool like grep and The Silver Searcher"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="15.1.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=046fa01a216793b8bd2750f9d68d4ad43986eb9c0d6122600f993906012972e8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="pcre2"
CLANDRO_PKG_RECOMMENDS="brotli, lz4"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--features pcre2"

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	# shell completions
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	cargo run -- --generate complete-bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}.bash"
	cargo run -- --generate complete-fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	cargo run -- --generate complete-zsh  > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"

	# Man page
	mkdir -p "${CLANDRO_PREFIX}/share/man/man1"
	cargo run -- --generate man > "${CLANDRO_PREFIX}/share/man/man1/${CLANDRO_PKG_NAME}.1"
}
