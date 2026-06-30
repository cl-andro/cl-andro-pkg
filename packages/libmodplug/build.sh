CLANDRO_PKG_HOMEPAGE=https://modplug-xmms.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="The ModPlug mod file playing library"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.9.1.r461
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ShiftMediaProject/modplug/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d489a13cc863180b0f8209ad7b69d4413df454858d6f4ce94a03669213dc56cd
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
