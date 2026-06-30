CLANDRO_PKG_HOMEPAGE=https://github.com/EFForg/apkeep
CLANDRO_PKG_DESCRIPTION="A command-line tool for downloading APK files from various sources"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.0"
CLANDRO_PKG_SRCURL=https://github.com/EFForg/apkeep/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0c7a9c84b5dff12c356b22878e4f88ff3f1b44500ff80436c9e64cee17146388
CLANDRO_PKG_DEPENDS="openssl (>= 3.0.3)"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$CLANDRO_PREFIX/include
	export OPENSSL_LIB_DIR=$CLANDRO_PREFIX/lib
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/apkeep
}
