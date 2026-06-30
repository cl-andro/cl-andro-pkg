CLANDRO_PKG_HOMEPAGE=https://github.com/LonnyGomes/hexcurse
CLANDRO_PKG_DESCRIPTION="Console hexeditor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.60.0
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/LonnyGomes/hexcurse/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f6919e4a824ee354f003f0c42e4c4cef98a93aa7e3aa449caedd13f9a2db5530
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"

clandro_step_pre_configure() {
	export CFLAGS+=" -fcommon -Wno-error=deprecated-non-prototype"
}
