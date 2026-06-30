CLANDRO_PKG_HOMEPAGE=https://github.com/tfenne/pipebuffer
CLANDRO_PKG_DESCRIPTION="Arbitrary-sized in-memory buffer between pipelined programs (non-blocking mbuffer analogue for pipeline)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.git20211120"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tfenne/pipebuffer/archive/9af1e18b38b9a62b054047e4131d4077cce101ae.tar.gz
CLANDRO_PKG_SHA256=cc73135fa4f3bec90ab762271122dd7671bfc9f664a9c4bda9734b661372ac6d
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -vDm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pipebuffer
	mkdir -vp $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME
	install -vpm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
}
