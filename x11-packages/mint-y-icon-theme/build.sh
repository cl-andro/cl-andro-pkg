CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/mint-y-icons
CLANDRO_PKG_DESCRIPTION="The Mint-Y icon theme for cinnamon"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.1"
CLANDRO_PKG_SRCURL=https://github.com/linuxmint/mint-y-icons/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6a2ca11c9bb93b52c9dd3ec72c991ac40ddcc015de823723de4768b0407a4dad
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="hicolor-icon-theme, adwaita-icon-theme, adwaita-icon-theme-legacy, mint-x-icon-theme, gtk-update-icon-cache"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	cp -r $CLANDRO_PKG_SRCDIR/usr/* $CLANDRO_PREFIX/
}
