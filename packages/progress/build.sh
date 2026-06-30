CLANDRO_PKG_HOMEPAGE=https://github.com/Xfennec/progress
CLANDRO_PKG_DESCRIPTION="Linux tool to show progress for cp, mv, dd and more"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.17"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Xfennec/progress/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ee9538fce98895dcf0d108087d3ee2e13f5c08ed94c983f0218a7a3d153b725d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libandroid-wordexp, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-wordexp"
}
