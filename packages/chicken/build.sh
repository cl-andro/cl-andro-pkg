CLANDRO_PKG_HOMEPAGE=https://www.call-cc.org
CLANDRO_PKG_DESCRIPTION="A feature rich Scheme compiler and interpreter"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.4.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://code.call-cc.org/releases/${CLANDRO_PKG_VERSION}/chicken-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3c5d4aa61c1167bf6d9bf9eaf891da7630ba9f5f3c15bf09515a7039bfcdec5f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
CSC_PROGRAM=chicken-csc
CSI_PROGRAM=chicken-csi
PLATFORM=android
"

clandro_step_pre_configure() {
	local ARCH="${CLANDRO_ARCH/_/-}" # Replace '_' in x86_64 with '-'.
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		ARCH="x86"
	fi
	CLANDRO_PKG_EXTRA_MAKE_ARGS+=" ARCH=${ARCH}"

	export C_COMPILER="$CC"
}
