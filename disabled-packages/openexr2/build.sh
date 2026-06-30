CLANDRO_PKG_HOMEPAGE=https://www.openexr.com/
CLANDRO_PKG_DESCRIPTION="Provides the specification and reference implementation of the EXR file format"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.5.8
CLANDRO_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=db261a7fcc046ec6634e4c5696a2fc2ce8b55f50aac6abe034308f54c8495f55
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
-DPYILMBASE_ENABLE=OFF
"

clandro_step_pre_configure() {
	case "$CLANDRO_PKG_VERSION" in
		2.*|*:2.* ) ;;
		* ) clandro_error_exit "Invalid version '$CLANDRO_PKG_VERSION' for package '$CLANDRO_PKG_NAME'." ;;
	esac
}
