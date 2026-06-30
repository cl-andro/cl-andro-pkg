CLANDRO_PKG_HOMEPAGE=https://github.com/ilai-deutel/kibi
CLANDRO_PKG_DESCRIPTION="A tiny terminal text editor, written in Rust"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.3"
CLANDRO_PKG_SRCURL=https://github.com/ilai-deutel/kibi/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a7a7b6f6937f39ae86fd4f556034a3744bb99091c102bc6f38b281ee751d10e9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm644 "config_example.ini" "$CLANDRO_PREFIX/etc/kibi/config.ini"
	install -Dm644 syntax.d/* -t "$CLANDRO_PREFIX/share/kibi/syntax.d"
}
