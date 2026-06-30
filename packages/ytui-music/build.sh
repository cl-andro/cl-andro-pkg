CLANDRO_PKG_HOMEPAGE=https://github.com/sudipghimire533/ytui-music
CLANDRO_PKG_DESCRIPTION="Youtube client in terminal for music"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.0-beta"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL="https://github.com/sudipghimire533/ytui-music/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=43deb6b3cb9eb836b7122ac2542106f46519f240f99a0af67eecdfa5b200cca7
CLANDRO_PKG_DEPENDS="libsqlite, mpv, openssl, python-yt-dlp"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$CLANDRO_PREFIX/include
	export OPENSSL_LIB_DIR=$CLANDRO_PREFIX/lib

	CLANDRO_PKG_SRCDIR+="/front-end"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"

	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ../target/${CARGO_TARGET_NAME}/release/ytui_music
}
