CLANDRO_PKG_HOMEPAGE=https://github.com/seenaburns/stag
CLANDRO_PKG_DESCRIPTION="Streaming bar graphs. For stats and stuff."
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/seenaburns/stag/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=391574e6aa12856d5a598a374e3a40a38cbab6ef9d769c0d59af8411b4fbecb6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS+=" $LDFLAGS"
}
