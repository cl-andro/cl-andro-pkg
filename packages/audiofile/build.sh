CLANDRO_PKG_HOMEPAGE="https://audiofile.68k.org/"
CLANDRO_PKG_DESCRIPTION="Silicon Graphics Audio File Library"
CLANDRO_PKG_LICENSE="Apache-2.0, GPL-2.0-or-later, LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.6"
CLANDRO_PKG_SRCURL="https://audiofile.68k.org/audiofile-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="cdc60df19ab08bfe55344395739bb08f50fc15c92da3962fac334d3bff116965"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="flac, libc++"
CLANDRO_PKG_BUILD_DEPENDS="alsa-lib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-docs
"

clandro_step_pre_configure() {
	export CXXFLAGS="-std=gnu++98 -Wno-deprecated-declarations"
	# Fixes undefined symbols in 32-bit ARM target:
	# ERROR: ./lib/libaudiofile.so.1.0.0 contains undefined symbols:
	# 8: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_ldivmod
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
