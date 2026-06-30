CLANDRO_PKG_HOMEPAGE=http://opentimeline.io/
CLANDRO_PKG_DESCRIPTION="Open Source API and interchange format for editorial timeline information."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.18.1"
CLANDRO_PKG_SRCURL="git+https://github.com/AcademySoftwareFoundation/OpenTimelineIO"
CLANDRO_PKG_SHA256=af81192a77f5fbf84f6e6a237910fc6e6999ad908bd20a685841ad4bb4a39a73
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="imath"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DOTIO_AUTOMATIC_SUBMODULES=OFF
-DOTIO_DEPENDENCIES_INSTALL=OFF
-DOTIO_FIND_IMATH=ON
-DOTIO_SHARED_LIBS=ON
"

clandro_step_post_get_source() {
	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]] ; then
		clandro_error_exit "Checksum mismatch for source files.\nExpected: ${CLANDRO_PKG_SHA256}\nActual:   ${s%% *}"
	fi
}
