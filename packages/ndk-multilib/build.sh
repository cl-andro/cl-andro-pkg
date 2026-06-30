CLANDRO_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
CLANDRO_PKG_DESCRIPTION="Multilib binaries for cross-compilation"
CLANDRO_PKG_LICENSE="NCSA"
CLANDRO_PKG_MAINTAINER="@clandro"
# Version should be equal to CLANDRO_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
CLANDRO_PKG_VERSION=29
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${CLANDRO_PKG_VERSION}-linux.zip
CLANDRO_PKG_SHA256=4abbbcdc842f3d4879206e9695d52709603e52dd68d3c1fff04b3b5e7a308ecf
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_BUILD_IN_SRC=true

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

prepare_libs() {
	local ARCH="$1"
	local SUFFIX="$2"
	local NDK_SUFFIX=$SUFFIX

	if [ $ARCH = x86 ] || [ $ARCH = x86_64 ]; then
		NDK_SUFFIX=$ARCH
	fi

	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib
	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/opt/ndk-multilib/$SUFFIX/lib
	local BASEDIR=toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$SUFFIX/
	cp $BASEDIR/${CLANDRO_PKG_API_LEVEL}/*.o $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib
	cp $BASEDIR/${CLANDRO_PKG_API_LEVEL}/lib{c,dl,log,m}.so $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/opt/ndk-multilib/$SUFFIX/lib
	cp $BASEDIR/libc++_shared.so $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib
	cp $BASEDIR/lib{c,dl,m}.a $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/opt/ndk-multilib/$SUFFIX/lib
	cp $BASEDIR/lib{c++_static,c++abi,c++experimental}.a $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib
	echo 'INPUT(-lc++_static -lc++abi)' > $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib/libc++_shared.a

	local f
	for f in lib{c,dl,log,m}.so lib{c,dl,m}.a; do
		ln -sfT $CLANDRO_PREFIX/opt/ndk-multilib/$SUFFIX/lib/${f} \
			$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib/${f}
	done

	if [ $ARCH == "x86" ]; then
		LIBATOMIC=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux/i386
	elif [ $ARCH == "arm64" ]; then
		LIBATOMIC=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux/aarch64
	else
		LIBATOMIC=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux/$ARCH
	fi

	cp $LIBATOMIC/libatomic.a $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib/

	cp $LIBATOMIC/libunwind.a $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$SUFFIX/lib/
}

add_cross_compiler_rt() {
	RT_PREFIX=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux
	RT_OPT_DIR=$CLANDRO_PREFIX/opt/ndk-multilib/cross-compiler-rt
	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$RT_OPT_DIR
	cp $RT_PREFIX/* $CLANDRO_PKG_MASSAGEDIR/$RT_OPT_DIR || true
}

clandro_step_make_install() {
	prepare_libs "arm" "arm-linux-androideabi"
	prepare_libs "arm64" "aarch64-linux-android"
	prepare_libs "x86" "i686-linux-android"
	prepare_libs "x86_64" "x86_64-linux-android"
	add_cross_compiler_rt
}

clandro_step_post_massage() {
	local triple f
	for triple in aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android; do
		for f in lib{c,dl,log,m}.so lib{c,dl,m}.a; do
			rm -f ${triple}/lib/${f}
		done
	done
}

clandro_step_create_debscripts() {
	local f
	for f in postinst prerm; do
		sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			-e "s|@CLANDRO_PACKAGE_FORMAT@|${CLANDRO_PACKAGE_FORMAT}|g" \
			$CLANDRO_PKG_BUILDER_DIR/postinst-header.in > "${f}"
	done
	sed 's|@COMMAND@|ln -sf "'$CLANDRO_PREFIX'/opt/ndk-multilib/$triple/lib/$so" "'$CLANDRO_PREFIX'/\$triple/lib"|' \
		$CLANDRO_PKG_BUILDER_DIR/postinst-alien.in >> postinst
	sed 's|@COMMAND@|rm -f "'$CLANDRO_PREFIX'/$triple/lib/$so"|' \
		$CLANDRO_PKG_BUILDER_DIR/postinst-alien.in >> prerm
	chmod 0700 postinst prerm
}
