CLANDRO_PKG_HOMEPAGE=https://github.com/Michael-F-Bryan/mdbook-epub
CLANDRO_PKG_DESCRIPTION="An EPUB renderer for mdbook"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.2"
CLANDRO_PKG_SRCURL=https://github.com/Michael-F-Bryan/mdbook-epub/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5040097cc5177012e15152d2bc548dbbad211adb91b3399a4c96fcc2ea966557
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local _patch=$CLANDRO_PKG_BUILDER_DIR/mdbook-src-renderer-html_handlebars-helpers-navigation.rs.diff
	local d
	for d in $CARGO_HOME/registry/src/*/mdbook-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-epub
}
