CLANDRO_PKG_HOMEPAGE=https://github.com/hackndev/0verkill
CLANDRO_PKG_DESCRIPTION="Bloody 2D action deathmatch-like game in ASCII-ART"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:0.16
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ravener/0verkill/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=d337e4a7dd91f26c837e96492d960c7fd77c75bc24bcc6ed8d350df39edf8bb8
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure() {
	autoreconf -vfi
	CFLAGS+=" -fcommon"
}
