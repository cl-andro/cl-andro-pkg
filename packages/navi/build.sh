CLANDRO_PKG_HOMEPAGE=https://github.com/denisidoro/navi
CLANDRO_PKG_DESCRIPTION="An interactive cheatsheet tool for the command-line"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.24.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/denisidoro/navi/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4c10f47c306826255b07483b7e94eed8ffc1401555c52434a56246295d3f2728
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fzf, git"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	rm -f Makefile
}

clandro_step_make_install() {
	clandro_setup_rust
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
	install -Dm755 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/navi"
}
