CLANDRO_PKG_HOMEPAGE=https://libcxx.llvm.org/
CLANDRO_PKG_DESCRIPTION="C++ Standard Library"
CLANDRO_PKG_LICENSE="NCSA"
CLANDRO_PKG_MAINTAINER="@clandro"
# Version should be equal to CLANDRO_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
CLANDRO_PKG_VERSION=29
CLANDRO_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${CLANDRO_PKG_VERSION}-linux.zip
CLANDRO_PKG_SHA256=4abbbcdc842f3d4879206e9695d52709603e52dd68d3c1fff04b3b5e7a308ecf
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		clandro_download_src_archive
		cd $CLANDRO_PKG_TMPDIR
		clandro_extract_src_archive
		mv "$CLANDRO_PKG_SRCDIR/android-ndk-r$CLANDRO_PKG_VERSION"/* "$CLANDRO_PKG_SRCDIR"
	else
		local lib_path="toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${CLANDRO_HOST_PLATFORM}"
		mkdir -p "$CLANDRO_PKG_SRCDIR"/"$lib_path"
		cp "$NDK"/"$lib_path"/libc++_shared.so "$CLANDRO_PKG_SRCDIR"/"$lib_path"
	fi
}

clandro_step_post_make_install() {
	install -m700 -t "$CLANDRO_PREFIX"/lib \
		toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/"${CLANDRO_HOST_PLATFORM}"/libc++_shared.so
}
