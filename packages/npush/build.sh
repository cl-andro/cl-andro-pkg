CLANDRO_PKG_HOMEPAGE=https://npush.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Curses-based logic game similar to Sokoban and Boulder Dash"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/npush/npush/${CLANDRO_PKG_VERSION}/npush-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=f216d2b3279e8737784f77d4843c9e6f223fa131ce1ebddaf00ad802aba2bcd9
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_post_get_source() {
	sed -i -e "s|\"levels|\"${CLANDRO_PREFIX}/share/npush/levels|" npush.cpp
}

clandro_step_make() {
	$CXX $CXXFLAGS $CPPFLAGS $LDFLAGS -lncurses -o npush npush.cpp
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin/ npush
	install -Dm644 -t $CLANDRO_PREFIX/share/npush/levels levels/*
}
