CLANDRO_PKG_HOMEPAGE="https://freeimage.sourceforge.io"
CLANDRO_PKG_DESCRIPTION="The library project for developers who would like to support popular graphics image formats"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="license-fi.txt, license-gplv2.txt, license-gplv3.txt, license-bsd-2-clause.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.18.0
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/project/freeimage/Source%20Distribution/${CLANDRO_PKG_VERSION}/FreeImage${CLANDRO_PKG_VERSION//./}.zip"
CLANDRO_PKG_SHA256=f41379682f9ada94ea7b34fe86bf9ee00935a3147be41b6569c9605a53e438fd
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CXXFLAGS+=" -std=c++11"

	cp -f "${CLANDRO_PKG_BUILDER_DIR}/license-bsd-2-clause.txt" "${CLANDRO_PKG_SRCDIR}"

	if [ "${CLANDRO_ARCH}" = "aarch64" ] || [ "${CLANDRO_ARCH}" = "arm" ]; then
		CFLAGS+=" -DPNG_ARM_NEON_OPT=0"
	fi

}
