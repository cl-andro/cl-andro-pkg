CLANDRO_PKG_HOMEPAGE=https://mate-terminal.mate-desktop.dev/
CLANDRO_PKG_DESCRIPTION="This is the MATE terminal emulator application"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.3"
CLANDRO_PKG_SRCURL=https://github.com/mate-desktop/mate-terminal/releases/download/v$CLANDRO_PKG_VERSION/mate-terminal-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=9c7d4f884fc21342814a186020e04aa1a5d436e9a13ea128d132e232d04b07e4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libvte, dconf, gtk3, libsm, mate-desktop"

clandro_step_pre_configure() {
	autoreconf -vfi
}
