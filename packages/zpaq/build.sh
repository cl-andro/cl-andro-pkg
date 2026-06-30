CLANDRO_PKG_HOMEPAGE=http://mattmahoney.net/dc/zpaq.html
CLANDRO_PKG_DESCRIPTION="Programmable file compressor, library and utilities. Based on the PAQ compression algorithm"
CLANDRO_PKG_LICENSE="MIT, Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=7.15
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/zpaq/zpaq/archive/refs/tags/${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=2d13de90fdd89a8e9eeda4afbf76610d3ace4aa675795b7c3a9f13b21fbdbe3e
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CXXFLAGS+=" -O3"
	if [ $CLANDRO_ARCH = "aarch64" ]; then
		CPPFLAGS+=" -DNOJIT"
	elif [ $CLANDRO_ARCH = "arm" ]; then
		CPPFLAGS+=" -DNOJIT"
	elif [ $CLANDRO_ARCH = "i686" ]; then
		CPPFLAGS+=" -Dunix"
	elif [ $CLANDRO_ARCH = "x86_64" ]; then
		CPPFLAGS+=" -Dunix"
	fi
}
