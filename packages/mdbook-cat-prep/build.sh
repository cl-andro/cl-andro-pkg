CLANDRO_PKG_HOMEPAGE=https://github.com/gjk-cat/cat-prep
CLANDRO_PKG_DESCRIPTION="A preprocessor for mdbook which provides teacher, subject, material and tag functionality"
CLANDRO_PKG_LICENSE="Fair"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=fbf5ca360337452ca5ef7437d64c2efd7d891aec
CLANDRO_PKG_VERSION=1.0.9
CLANDRO_PKG_SRCURL=git+https://github.com/gjk-cat/cat-prep
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_BUILD_IN_SRC=true

# https://github.com/termux/termux-packages/issues/16756
CLANDRO_RUST_VERSION=1.68.2

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local ver=$(sed -En 's/^version = "([^"]+)".*/\1/p' Cargo.toml)
	if [ "${ver}" != "${CLANDRO_PKG_VERSION#*:}" ]; then
		clandro_error_exit "Version string '$CLANDRO_PKG_VERSION' does not seem to be correct."
	fi
}

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
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-cat-prep
}
