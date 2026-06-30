CLANDRO_PKG_HOMEPAGE=https://rust-lang.github.io/mdBook/
CLANDRO_PKG_DESCRIPTION="Creates book from markdown files"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.2"
CLANDRO_PKG_SRCURL=https://github.com/rust-lang/mdBook/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2c8615a17c5670f9aa6d8dbf77c343cf430f95f571f28a87bb7aaa8f29c1ac5b
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook
}
