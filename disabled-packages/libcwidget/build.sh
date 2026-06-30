CLANDRO_PKG_HOMEPAGE=https://salsa.debian.org/cwidget-team/
CLANDRO_PKG_DESCRIPTION="high-level terminal interface library for C++"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.18
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/c/cwidget/cwidget_$CLANDRO_PKG_VERSION.orig.tar.xz
CLANDRO_PKG_SHA256=a2fb48ff86e41fe15072e6d87b9467ff3af57329586f4548d9f25cf50491c9fc
CLANDRO_PKG_DEPENDS="ncurses, libiconv, libsigc++-2.0"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-werror"

clandro_step_pre_configure() {
	CXXFLAGS+=" -DNCURSES_WIDECHAR=1"
	LDFLAGS+=" -liconv"

	if [ $CLANDRO_ARCH = aarch64 ] || [ $CLANDRO_ARCH = arm ]; then
		LDFLAGS+=" $($CC -print-libgcc-file-name)"
	fi
}
