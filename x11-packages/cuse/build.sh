CLANDRO_PKG_HOMEPAGE=https://pi4.informatik.uni-mannheim.de/~haensel/cuse/
CLANDRO_PKG_DESCRIPTION="A MIDI-Sequencer which targets both terminal purists and visually impaired people"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/cuse/cuse-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=dc2306c68eeb0eefb2da4739cf42bf3bf49fde3adba6ca58900fb3f78d4f9ad6
CLANDRO_PKG_DEPENDS="libc++, libcdk, ncurses, sdl, sdl-mixer"

clandro_step_post_get_source() {
	make distclean || :
}

clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -lSDL"
}
