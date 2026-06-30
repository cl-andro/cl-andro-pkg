CLANDRO_PKG_HOMEPAGE="https://github.com/jridgewell/rw"
CLANDRO_PKG_DESCRIPTION="A Rust implementation of sponge(1) that never write to TMPDIR"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=("https://github.com/jridgewell/rw/archive/c13c24e011ef5a79ea60bc51bb0d3fa930326146.tar.gz")
CLANDRO_PKG_SHA256=(699c32045c713bcfc8e7b89d5bd24d89d1cbb887ba8570b857391f98b64e6a9a)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rw
}
