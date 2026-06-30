CLANDRO_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
CLANDRO_PKG_DESCRIPTION="System header and library files from the Android NDK needed for compiling C programs"
CLANDRO_PKG_LICENSE="NCSA"
CLANDRO_PKG_MAINTAINER="@clandro"
# Version should be equal to CLANDRO_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
CLANDRO_PKG_VERSION=29
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${CLANDRO_PKG_VERSION}-linux.zip
CLANDRO_PKG_SHA256=4abbbcdc842f3d4879206e9695d52709603e52dd68d3c1fff04b3b5e7a308ecf
CLANDRO_PKG_AUTO_UPDATE=false
# This package has taken over <pty.h> from the previous libutil-dev
# and iconv.h from libandroid-support-dev:
CLANDRO_PKG_CONFLICTS="libutil-dev, libgcc, libandroid-support-dev"
CLANDRO_PKG_REPLACES="libutil-dev, libgcc, libandroid-support-dev, ndk-stl"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_RM_AFTER_INSTALL="
include/EGL
include/GLES
include/GLES2
include/GLES3
include/KHR/khrplatform.h
include/execinfo.h
include/glob.h
include/iconv.h
include/spawn.h
include/sys/capability.h
include/sys/sem.h
include/sys/shm.h
include/unicode
include/vk_video
include/vulkan
include/zconf.h
include/zlib.h
"

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		clandro_download_src_archive
		cd $CLANDRO_PKG_TMPDIR
		clandro_extract_src_archive
		mv "$CLANDRO_PKG_SRCDIR/android-ndk-r$CLANDRO_PKG_VERSION"/* "$CLANDRO_PKG_SRCDIR"
	else
		local lib_path="toolchains/llvm/prebuilt/linux-x86_64/sysroot"
		mkdir -p "$CLANDRO_PKG_SRCDIR"/"$lib_path"
		cp -fr "$NDK"/"$lib_path"/* "$CLANDRO_PKG_SRCDIR"/"$lib_path"/
		lib_path="toolchains/llvm/prebuilt/linux-x86_64/lib"
		mkdir -p "$CLANDRO_PKG_SRCDIR"/"$lib_path"
		cp -fr "$NDK"/"$lib_path"/* "$CLANDRO_PKG_SRCDIR"/"$lib_path"/
	fi
}

clandro_step_post_get_source() {
	pushd toolchains/llvm/prebuilt/linux-x86_64/sysroot/
	for patch in $CLANDRO_SCRIPTDIR/ndk-patches/$CLANDRO_PKG_VERSION/*.patch; do
		echo "Applying ndk patch: $(basename $patch)"
		test -f "$patch" && sed \
			-e "s%\@CLANDRO_APP_PACKAGE\@%${CLANDRO_APP_PACKAGE}%g" \
			-e "s%\@CLANDRO_BASE_DIR\@%${CLANDRO_BASE_DIR}%g" \
			-e "s%\@CLANDRO_CACHE_DIR\@%${CLANDRO_CACHE_DIR}%g" \
			-e "s%\@CLANDRO_HOME\@%${CLANDRO_ANDROID_HOME}%g" \
			-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
			"$patch" | patch --silent -p1
	done
	grep -lrw usr/include/c++/v1 -e 'include <version>' | xargs -n 1 sed -i 's/include <version>/include \"version\"/g'
	popd
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/include

	cp -Rf toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/* \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/include


	find $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/include -name \*.orig -delete

	cp $CLANDRO_SCRIPTDIR/ndk-patches/{langinfo,libintl}.h $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/include/

	cp toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/$CLANDRO_PKG_API_LEVEL/*.o \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib

	cp toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/libcompiler_rt-extras.a \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/

	cp toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/libc++experimental.a \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/

	NDK_ARCH=$CLANDRO_ARCH
	test $NDK_ARCH == 'i686' && NDK_ARCH='i386'

	# clang requires libunwind on Android.
	cp toolchains/llvm/prebuilt/linux-x86_64/lib/clang/21/lib/linux/$NDK_ARCH/libatomic.a \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib
	cp toolchains/llvm/prebuilt/linux-x86_64/lib/clang/21/lib/linux/$NDK_ARCH/libunwind.a \
		$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib

	# librt and libpthread are built into libc on android, so setup them as symlinks
	# to libc for compatibility with programs that users try to build:
	for lib in librt.so libpthread.so libutil.so; do
		echo 'INPUT(-lc)' > $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/$lib
	done
	unset lib
}
