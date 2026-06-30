CLANDRO_PKG_HOMEPAGE=https://github.com/orf/gping
CLANDRO_PKG_DESCRIPTION="Ping, but with a graph"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="1.20.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/orf/gping/archive/refs/tags/gping-v$CLANDRO_PKG_VERSION.zip
CLANDRO_PKG_SHA256=3da3b39f92a4bc9fdd42799410e9ad1d58ae317b5f13649ffcb31d8c11a80674
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_BUILD_DEPENDS="zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	# conflicts with rust host build
	unset CFLAGS
}

clandro_step_make() {
	cd gping
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	cd ..
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/gping
}
