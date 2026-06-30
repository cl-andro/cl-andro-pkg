CLANDRO_PKG_HOMEPAGE=https://github.com/dylanowen/mdbook-graphviz
CLANDRO_PKG_DESCRIPTION="mdbook preprocessor to add graphviz support"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.1"
CLANDRO_PKG_SRCURL=https://github.com/dylanowen/mdbook-graphviz/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=606842d7afbcefb2517c8fbd6993eadd18b41c5379eaa7602f5fb668d5b92b5d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="graphviz"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-graphviz
}
