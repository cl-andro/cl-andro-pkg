CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/vivid
CLANDRO_PKG_DESCRIPTION="A themeable LS_COLORS generator with a rich filetype datebase"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.1"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/vivid/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a43ccfbc6554055181a08f2740664f9280fa2d0e57c4641850c60dd0e5323720
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
