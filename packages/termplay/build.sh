CLANDRO_PKG_HOMEPAGE=https://gitlab.com/jD91mZM2/termplay
CLANDRO_PKG_DESCRIPTION="Plays an image/video in your terminal"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.6
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.com/jD91mZM2/termplay/-/archive/v${CLANDRO_PKG_VERSION}/termplay-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fba29bf75640c698079b22eeb05e3fdc81c8abc7b232bd9b6752f267aa5405e0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="glib, gst-plugins-base, gstreamer, libsixel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release \
		--features bin
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/termplay
}
