CLANDRO_PKG_HOMEPAGE=https://github.com/podsvirov/mdbook-pikchr
CLANDRO_PKG_DESCRIPTION="A mdbook preprocessor to render pikchr code blocks as images in your book"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.0"
CLANDRO_PKG_SRCURL=git+https://github.com/podsvirov/mdbook-pikchr
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-pikchr
}
