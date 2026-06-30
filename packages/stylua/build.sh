CLANDRO_PKG_HOMEPAGE=https://github.com/JohnnyMorganz/StyLua
CLANDRO_PKG_DESCRIPTION="An opinionated Lua code formatter"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.1"
CLANDRO_PKG_SRCURL=https://github.com/JohnnyMorganz/StyLua/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=882eadb417294399a89ba2b3f17edc751d4b6d1892e4814bfbf5c024bb89de6c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --all-features

}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/stylua
}
