CLANDRO_PKG_HOMEPAGE=https://github.com/badboy/mdbook-open-on-gh
CLANDRO_PKG_DESCRIPTION="A preprocessor for mdbook to add a open-on-github link on every page"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.0"
CLANDRO_PKG_SRCURL=git+https://github.com/badboy/mdbook-open-on-gh
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-open-on-gh
}
