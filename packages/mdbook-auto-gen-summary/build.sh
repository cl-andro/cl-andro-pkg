CLANDRO_PKG_HOMEPAGE=https://github.com/cococolanosugar/mdbook-auto-gen-summary
CLANDRO_PKG_DESCRIPTION="A preprocessor and cli tool for mdbook to auto generate summary"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=a8e1d8edba05c52d927880a5fe2b97180441c955
CLANDRO_PKG_VERSION=0.1.10
CLANDRO_PKG_SRCURL=git+https://github.com/cococolanosugar/mdbook-auto-gen-summary
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_BUILD_IN_SRC=true

# https://github.com/termux/termux-packages/issues/12824
CLANDRO_RUST_VERSION=1.63.0

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

	local _patch=$CLANDRO_PKG_BUILDER_DIR/filetime-src-unix-utimes.rs.diff
	local d
	for d in $CARGO_HOME/registry/src/*/filetime-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-auto-gen-summary
}
