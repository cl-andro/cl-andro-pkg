CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/mint-x-icons
CLANDRO_PKG_DESCRIPTION="The Mint-X icon theme for cinnamon"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.5"
CLANDRO_PKG_SRCURL=https://github.com/linuxmint/mint-x-icons/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c78f4fb6187a4eed78105cd1d62e2d93b46525eca6c4e95d961cb375ce480108
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="hicolor-icon-theme, adwaita-icon-theme, adwaita-icon-theme-legacy, gtk-update-icon-cache"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	cp -r $CLANDRO_PKG_SRCDIR/usr/* $CLANDRO_PREFIX/
}
