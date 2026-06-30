CLANDRO_PKG_HOMEPAGE=https://dwm.suckless.org/
CLANDRO_PKG_DESCRIPTION="A dynamic window manager for X"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.8"
CLANDRO_PKG_SRCURL="https://dl.suckless.org/dwm/dwm-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=bcf540589ad174d4073f4efa658828411e2f5ba63196cfaf6b71363700f590b7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dmenu, fontconfig, libx11, libxft, libxinerama, st"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	cp config.def.h config.h
}
