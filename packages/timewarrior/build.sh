CLANDRO_PKG_HOMEPAGE=https://timewarrior.net/
CLANDRO_PKG_DESCRIPTION="Command-line time tracker"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.1"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=git+https://github.com/GothenburgBitFactory/timewarrior
CLANDRO_PKG_DEPENDS="libandroid-glob, libc++"

# Installation of man pages is broken as of version 1.4.3.
CLANDRO_PKG_RM_AFTER_INSTALL="share/man"

clandro_step_pre_configure() {
	# Fix i686 builds.
	CXXFLAGS+=" -Wno-c++11-narrowing"

	LDFLAGS+=" -landroid-glob"
}
