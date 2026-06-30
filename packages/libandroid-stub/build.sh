CLANDRO_PKG_HOMEPAGE=https://android.googlesource.com/platform/frameworks/base/+/main/native/android
CLANDRO_PKG_DESCRIPTION="Stub libandroid.so for non-Android certified environment"
CLANDRO_PKG_LICENSE="NCSA"
CLANDRO_PKG_MAINTAINER="@clandro"
# Version should be equal to CLANDRO_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
CLANDRO_PKG_VERSION=29
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_CONFLICTS="libandroid"
CLANDRO_PKG_REPLACES="libandroid"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_API_LEVEL=28

clandro_step_make() {
	local stub
	for stub in android mediandk OpenSLES; do
		"${CC}" -shared -fPIC \
			-o "${CLANDRO_PREFIX}/lib/lib${stub}.so" \
			"${CLANDRO_PKG_BUILDER_DIR}/lib${stub}-wrapper.c" \
			$CFLAGS $LDFLAGS \
			-Wno-deprecated-declarations \
			-Wl,--no-use-android-relr-tags \
			-Wl,--pack-dyn-relocs=android
	done
}
