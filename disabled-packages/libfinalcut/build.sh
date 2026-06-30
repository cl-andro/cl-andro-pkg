CLANDRO_PKG_HOMEPAGE=https://github.com/gansm/finalcut
CLANDRO_PKG_DESCRIPTION="A C++ class library and widget toolkit for creating a text-based user interface"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.1"
CLANDRO_PKG_SRCURL=https://github.com/gansm/finalcut/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6593b3c43ba1de98e4e0e3a563dbf9316fade71ef85c82e6b6f086184ec69a56
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
