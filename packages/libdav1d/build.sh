CLANDRO_PKG_HOMEPAGE=https://code.videolan.org/videolan/dav1d/
CLANDRO_PKG_DESCRIPTION="AV1 cross-platform decoder focused on speed and correctness"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.3"
CLANDRO_PKG_SRCURL=https://code.videolan.org/videolan/dav1d/-/archive/${CLANDRO_PKG_VERSION}/dav1d-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=e099f53253f6c247580c554d53a13f1040638f2066edc3c740e4c2f15174ce22
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_tools=true
-Denable_tests=false
"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = "i686" ]; then
		# Avoid text relocations.
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Denable_asm=false"
	fi
}
