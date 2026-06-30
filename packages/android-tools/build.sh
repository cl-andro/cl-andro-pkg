CLANDRO_PKG_HOMEPAGE=https://developer.android.com/
CLANDRO_PKG_DESCRIPTION="Android platform tools"
CLANDRO_PKG_LICENSE="Apache-2.0, BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE, vendor/core/fastboot/LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="35.0.2"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/nmeum/android-tools/releases/download/$CLANDRO_PKG_VERSION/android-tools-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=d2c3222280315f36d8bfa5c02d7632b47e365bfe2e77e99a3564fb6576f04097
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="abseil-cpp, brotli, fmt, libc++, liblz4, libprotobuf, pcre2, zlib, zstd"
CLANDRO_PKG_BUILD_DEPENDS="googletest"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_TOOLS_USE_BUNDLED_LIBUSB=ON
"

clandro_step_pre_configure() {
	clandro_setup_protobuf
	clandro_setup_golang

	LDFLAGS+=" $($CLANDRO_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}
