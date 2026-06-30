CLANDRO_PKG_HOMEPAGE=https://neocmakelsp.github.io/
CLANDRO_PKG_DESCRIPTION="a cmake lsp based on tower-lsp and treesitter"
CLANDRO_PKG_LICENSE=MIT
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.2"
CLANDRO_PKG_SRCURL=https://github.com/neocmakelsp/neocmakelsp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=55ae5a731fa3b7091dc8474420ba76f61a5228067ce71d69cc0d3fcc5d6f83dd
CLANDRO_PKG_DEPENDS="cmake"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -f meson.build
}

clandro_step_post_make_install() {
	install -Dm600 -t "${CLANDRO_PREFIX}/share/bash-completion/completions" completions/bash/neocmakelsp
	install -Dm600 -t "${CLANDRO_PREFIX}/share/fish/vendor_completions.d" completions/fish/neocmakelsp.fish
	install -Dm600 -t "${CLANDRO_PREFIX}/share/zsh/site-functions" completions/zsh/_neocmakelsp
}
