clandro_setup_toolchain_29() {
	export CFLAGS=""
	export CPPFLAGS=""
	export LDFLAGS="-L${CLANDRO__PREFIX__LIB_DIR}"

	export AS=$CLANDRO_HOST_PLATFORM-clang
	export CC=$CLANDRO_HOST_PLATFORM-clang
	export CPP=$CLANDRO_HOST_PLATFORM-cpp
	export CXX=$CLANDRO_HOST_PLATFORM-clang++
	export LD=ld.lld
	export AR=llvm-ar
	export OBJCOPY=llvm-objcopy
	export OBJDUMP=llvm-objdump
	export RANLIB=llvm-ranlib
	export READELF=llvm-readelf
	export STRIP=llvm-strip
	export NM=llvm-nm
	export CXXFILT=llvm-cxxfilt

	export CLANDRO_GHC_OPTIMISATION="-O"
	if [ "${CLANDRO_DEBUG_BUILD}" = true ]; then
		CLANDRO_GHC_OPTIMISATION="-O0"
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		export PATH=$CLANDRO_STANDALONE_TOOLCHAIN/bin:$PATH
		export CC_FOR_BUILD=gcc
		export PKG_CONFIG=$CLANDRO_STANDALONE_TOOLCHAIN/bin/pkg-config
		export PKGCONFIG=$PKG_CONFIG
		export CCLANDRO_HOST_PLATFORM=$CLANDRO_HOST_PLATFORM$CLANDRO_PKG_API_LEVEL
		if [ $CLANDRO_ARCH = arm ]; then
			CCLANDRO_HOST_PLATFORM=armv7a-linux-androideabi$CLANDRO_PKG_API_LEVEL
		fi
		LDFLAGS+=" -Wl,-rpath=$CLANDRO__PREFIX__LIB_DIR"
	else
		export CC_FOR_BUILD=$CC
		# Some build scripts use environment variable 'PKG_CONFIG', so
		# using this for on-device builds too.
		export PKG_CONFIG=pkg-config
	fi
	export PKG_CONFIG_LIBDIR="$CLANDRO_PKG_CONFIG_LIBDIR"

	if [ "$CLANDRO_ARCH" = "arm" ]; then
		# https://developer.android.com/ndk/guides/standalone_toolchain.html#abi_compatibility:
		# "We recommend using the -mthumb compiler flag to force the generation of 16-bit Thumb-2 instructions".
		# With r13 of the ndk ruby 2.4.0 segfaults when built on arm with clang without -mthumb.
		CFLAGS+=" -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb"
		LDFLAGS+=" -march=armv7-a"
		export GOARCH=arm
		export GOARM=7
	elif [ "$CLANDRO_ARCH" = "i686" ]; then
		# From $NDK/docs/CPU-ARCH-ABIS.html:
		CFLAGS+=" -march=i686 -msse3 -mstackrealign -mfpmath=sse"
		# i686 seem to explicitly require -fPIC, see
		# https://github.com/termux/termux-packages/issues/7215#issuecomment-906154438
		CFLAGS+=" -fPIC"
		export GOARCH=386
		export GO386=sse2
	elif [ "$CLANDRO_ARCH" = "aarch64" ]; then
		export GOARCH=arm64
	elif [ "$CLANDRO_ARCH" = "x86_64" ]; then
		export GOARCH=amd64
	else
		clandro_error_exit "Invalid arch '$CLANDRO_ARCH' - support arches are 'arm', 'i686', 'aarch64', 'x86_64'"
	fi

	# Android 7 started to support DT_RUNPATH (but not DT_RPATH).
	LDFLAGS+=" -Wl,--enable-new-dtags"

	# Avoid linking extra (unneeded) libraries.
	LDFLAGS+=" -Wl,--as-needed"

	# Basic hardening.
	CFLAGS+=" -fstack-protector-strong"
	LDFLAGS+=" -Wl,-z,relro,-z,now"

	if [ "$CLANDRO_DEBUG_BUILD" = "true" ]; then
		CFLAGS+=" -g3 -O1"
		CPPFLAGS+=" -D_FORTIFY_SOURCE=2 -D__USE_FORTIFY_LEVEL=2"
	else
		CFLAGS+=" -Oz"
	fi

	export CXXFLAGS="$CFLAGS"
	# set the proper header include order - first package includes, then prefix includes
	# -isystem${CLANDRO__PREFIX__BASE_INCLUDE_DIR}/c++/v1 is needed here for on-device building to work correctly
	export CPPFLAGS+=" -isystem${CLANDRO__PREFIX__BASE_INCLUDE_DIR}/c++/v1 -isystem${CLANDRO__PREFIX__INCLUDE_DIR}"
	if [ "$CLANDRO_ARCH" != "$CLANDRO_REAL_ARCH" ]; then
		export CPPFLAGS+=" -isystem${CLANDRO__PREFIX__BASE_INCLUDE_DIR}"
	fi

	# If libandroid-support is declared as a dependency, link to it explicitly:
	if [ "$CLANDRO_PKG_DEPENDS" != "${CLANDRO_PKG_DEPENDS/libandroid-support/}" ]; then
		LDFLAGS+=" -Wl,--no-as-needed,-landroid-support,--as-needed"
	fi

	export GOOS=android
	export CGO_ENABLED=1
	export GO_LDFLAGS="-extldflags=-pie"
	export CGO_LDFLAGS="${LDFLAGS/ -Wl,-z,relro,-z,now/}"
	export CGO_CFLAGS="-isystem${CLANDRO__PREFIX__INCLUDE_DIR}"
	if [ "$CLANDRO_ARCH" != "$CLANDRO_REAL_ARCH" ]; then
		export CGO_CFLAGS+=" -isystem${CLANDRO__PREFIX__BASE_INCLUDE_DIR}"
	fi

	export CARGO_TARGET_NAME="${CLANDRO_ARCH}-linux-android"
	if [[ "${CLANDRO_ARCH}" == "arm" ]]; then
		CARGO_TARGET_NAME="armv7-linux-androideabi"
	fi
	local env_host="${CARGO_TARGET_NAME//-/_}"
	export CARGO_TARGET_${env_host@U}_LINKER="${CC}"
	export CARGO_TARGET_${env_host@U}_RUSTFLAGS="-L${CLANDRO__PREFIX__LIB_DIR} -C link-arg=-Wl,-rpath=${CLANDRO__PREFIX__LIB_DIR} -C link-arg=-Wl,--enable-new-dtags"
	export CFLAGS_${env_host}="${CPPFLAGS} ${CFLAGS}"
	export CC_x86_64_unknown_linux_gnu="gcc"
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"
	export PKG_CONFIG_x86_64_unknown_linux_gnu="/usr/bin/pkg-config"
	export PKG_CONFIG_LIBDIR_x86_64_unknown_linux_gnu="/usr/lib/pkgconfig"
	export RUST_BACKTRACE="full"

	export ac_cv_func_getpwent=no
	export ac_cv_func_endpwent=yes
	export ac_cv_func_getpwnam=no
	export ac_cv_func_getpwuid=no
	export ac_cv_func_sigsetmask=no
	export ac_cv_c_bigendian=no

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		return
	fi

	[ -d "$CLANDRO_STANDALONE_TOOLCHAIN" ] || mkdir -p "$CLANDRO_STANDALONE_TOOLCHAIN"
	[ -d "${CLANDRO_STANDALONE_TOOLCHAIN}-upper" ] || mkdir -p "${CLANDRO_STANDALONE_TOOLCHAIN}-upper"
	[ -d "${CLANDRO_STANDALONE_TOOLCHAIN}-work" ] || mkdir -p "${CLANDRO_STANDALONE_TOOLCHAIN}-work"


	if ! mountpoint -q "${CLANDRO_STANDALONE_TOOLCHAIN}"; then
		fuse-overlayfs \
			"${CLANDRO_STANDALONE_TOOLCHAIN}" \
			-o lowerdir="${NDK}/toolchains/llvm/prebuilt/linux-x86_64" \
			-o upperdir="${CLANDRO_STANDALONE_TOOLCHAIN}-upper" \
			-o workdir="${CLANDRO_STANDALONE_TOOLCHAIN}-work"
	fi

	if [ -f "${CLANDRO_STANDALONE_TOOLCHAIN}/.clandro-standalone-toolchain" ]; then
		return
	fi

	local _NDK_ARCHNAME=$CLANDRO_ARCH
	if [ "$CLANDRO_ARCH" = "aarch64" ]; then
		_NDK_ARCHNAME=arm64
	elif [ "$CLANDRO_ARCH" = "i686" ]; then
		_NDK_ARCHNAME=x86
	fi
	# Remove android-support header wrapping not needed on android-21:
	rm -Rf $CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/local

	for HOST_PLAT in aarch64-linux-android armv7a-linux-androideabi i686-linux-android x86_64-linux-android; do
		cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT$CLANDRO_PKG_API_LEVEL-clang \
			$CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang
		cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT$CLANDRO_PKG_API_LEVEL-clang++ \
			$CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang++

		cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT$CLANDRO_PKG_API_LEVEL-clang \
			$CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-cpp
		sed -i 's|"$bin_dir/clang"|& -E|' \
			$CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-cpp

		cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang \
			$CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-gcc
		cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang++ \
			$CLANDRO_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-g++
	done

	cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/armv7a-linux-androideabi$CLANDRO_PKG_API_LEVEL-clang \
		$CLANDRO_STANDALONE_TOOLCHAIN/bin/arm-linux-androideabi-clang
	cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/armv7a-linux-androideabi$CLANDRO_PKG_API_LEVEL-clang++ \
		$CLANDRO_STANDALONE_TOOLCHAIN/bin/arm-linux-androideabi-clang++
	cp $CLANDRO_STANDALONE_TOOLCHAIN/bin/armv7a-linux-androideabi-cpp \
		$CLANDRO_STANDALONE_TOOLCHAIN/bin/arm-linux-androideabi-cpp

	# rust 1.75.0+ expects this directory to be present
	rm -fr "${CLANDRO_STANDALONE_TOOLCHAIN}"/toolchains
	mkdir -p "${CLANDRO_STANDALONE_TOOLCHAIN}"/toolchains/llvm/prebuilt
	ln -fs ../../.. "${CLANDRO_STANDALONE_TOOLCHAIN}"/toolchains/llvm/prebuilt/linux-x86_64

	# Create a pkg-config wrapper. We use path to host pkg-config to
	# avoid picking up a cross-compiled pkg-config later on.
	local _HOST_PKGCONFIG
	_HOST_PKGCONFIG=$(command -v pkg-config)
	mkdir -p "$PKG_CONFIG_LIBDIR"
	cat > $CLANDRO_STANDALONE_TOOLCHAIN/bin/pkg-config <<-HERE
		#!/bin/sh
		export PKG_CONFIG_DIR=
		export PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR
		exec $_HOST_PKGCONFIG "\$@"
	HERE
	chmod +x "$CLANDRO_STANDALONE_TOOLCHAIN"/bin/pkg-config

	cd $CLANDRO_STANDALONE_TOOLCHAIN/sysroot
	for f in $CLANDRO_SCRIPTDIR/ndk-patches/$CLANDRO_NDK_VERSION/*.patch; do
		echo "Applying ndk-patch: $(basename $f)"
		sed "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" "$f" | \
			sed "s%\@CLANDRO_HOME\@%${CLANDRO_ANDROID_HOME}%g" | \
			patch --silent -p1;
	done
	# libintl.h: Inline implementation gettext functions.
	# langinfo.h: Inline implementation of nl_langinfo().
	cp "$CLANDRO_SCRIPTDIR"/ndk-patches/{libintl.h,langinfo.h} usr/include

	# Remove <sys/capability.h> because it is provided by libcap.
	# Remove <sys/shm.h> from the NDK in favour of that from the libandroid-shmem.
	# Remove <sys/sem.h> as it doesn't work for non-root.
	# Remove <glob.h> as we currently provide it from libandroid-glob.
	# Remove <iconv.h> as it's provided by libiconv.
	# Remove <spawn.h> as it's only for future (later than android-27).
	# Remove <zlib.h> and <zconf.h> as we build our own zlib.
	# Remove unicode headers provided by libicu.
	# Remove KHR/khrplatform.h provided by mesa.
	# Remove EGL, GLES, GLES2, and GLES3 provided by mesa.
	# Remove execinfo provided by libandroid-execinfo.
	# Remove NDK vulkan headers.
	rm usr/include/{sys/{capability,shm,sem},{glob,iconv,spawn,zlib,zconf},KHR/khrplatform,execinfo}.h
	rm usr/include/unicode/{char16ptr,platform,ptypes,putil,stringoptions,ubidi,ubrk,uchar,uconfig,ucpmap,udisplaycontext,uenum,uldnames,ulocdata,uloc,umachine,unorm2,urename,uscript,ustring,utext,utf16,utf8,utf,utf_old,utypes,uvernum,uversion}.h
	rm -Rf usr/include/vulkan
	rm -Rf usr/include/{EGL,GLES{,2,3}}

	$CLANDRO_ELF_CLEANER --api-level=$CLANDRO_PKG_API_LEVEL usr/lib/*/*/*.so | { [[ "${CI-}" == "true" ]] && sed -e '1i\::group::Applying `clandro-elf-cleaner`' -e '$a\::endgroup::' || cat; }
	for dir in usr/lib/*; do
		# This seem to be needed when building rust
		# packages
		echo 'INPUT(-lunwind)' > $dir/libgcc.a
	done

	grep -lrw $CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/include/c++/v1 -e 'include <version>' | xargs -n 1 sed -i 's/include <version>/include \"version\"/g'

	touch ${CLANDRO_STANDALONE_TOOLCHAIN}/.clandro-standalone-toolchain
}
