CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/chess/
CLANDRO_PKG_DESCRIPTION="Chess-playing program"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.3.0"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/chess/gnuchess-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0b37bec2098c2ad695b7443e5d7944dc6dc8284f8d01fcc30bdb94dd033ca23a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="readline"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/gnuchessu bin/gnuchessx"
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure() {
	CXXFLAGS+=" -Wno-error=register"
}
