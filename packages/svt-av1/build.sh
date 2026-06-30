CLANDRO_PKG_HOMEPAGE=https://gitlab.com/AOMediaCodec/SVT-AV1
CLANDRO_PKG_DESCRIPTION="Scalable Video Technology for AV1 (SVT-AV1 Encoder and Decoder)"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE.md, PATENTS.md"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.1.0"
CLANDRO_PKG_SRCURL="https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v${CLANDRO_PKG_VERSION}/SVT-AV1-v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=6c4c0c44ff0ba3d136d6f57f3a707f9de8e9c866f50f809c1d22a43f0d8c9583
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
-DCMAKE_OUTPUT_DIRECTORY=$CLANDRO_PKG_BUILDDIR
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local expected_soversion=4

	local current_soversion=$(sed -En 's/^project\(svt-av1 VERSION ([0-9]+).([0-9]+).([0-9]+)$/\1/p' CMakeLists.txt)

	if [ ! "${current_soversion}" ] || [ "${current_soversion}" != "${expected_soversion}" ]; then
		clandro_error_exit "SOVERSION guard check failed. Expected ${expected_soversion}, got ${current_soversion}."
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
	case "${CLANDRO_ARCH}" in
	x86_64) LDFLAGS+=" -llog" ;;
	esac
}
