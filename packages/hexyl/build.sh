CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/hexyl
CLANDRO_PKG_DESCRIPTION="A command-line hex viewer"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.17.0"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/hexyl/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=72fa17397ad187eec6b295d02c7caabbb209a6e0d5706187b8a599bd5df8615e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	mkdir -p "${CLANDRO_PREFIX}"/share/man/man1
	pandoc --standalone --to man doc/hexyl.1.md --output "${CLANDRO_PREFIX}"/share/man/man1/hexyl.1
}
