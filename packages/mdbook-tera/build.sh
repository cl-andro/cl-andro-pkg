CLANDRO_PKG_HOMEPAGE=https://github.com/avitex/mdbook-tera
CLANDRO_PKG_DESCRIPTION="Tera preprocessor for mdBook"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/avitex/mdbook-tera/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=676477d95fa0b8f23962ccf52aa4b394d0ebac0044d33f9f11d995d8d3b98d3d
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
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-tera
}
