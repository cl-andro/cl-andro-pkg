CLANDRO_PKG_HOMEPAGE=https://github.com/zigtools/zls
CLANDRO_PKG_DESCRIPTION="Zig language server"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.16.0"
CLANDRO_PKG_SRCURL="https://github.com/zigtools/zls/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e7c5936f5b3a057ce851be0876e4e259b5c4d02f9aae038cd24a5d6b586b029f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_zig
	zig build -Dtarget="$ZIG_TARGET_NAME" -Doptimize=ReleaseSafe
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" zig-out/bin/zls
}
