CLANDRO_PKG_HOMEPAGE=https://www.webmproject.org
CLANDRO_PKG_DESCRIPTION="VP8 & VP9 Codec SDK"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:1.16.0"
CLANDRO_PKG_SRCURL="https://github.com/webmproject/libvpx/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=7a479a3c66b9f5d5542a4c6a1b7d3768a983b1e5c14c60a9396edc9b649e015c
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="libvpx-dev"
CLANDRO_PKG_REPLACES="libvpx-dev"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"

clandro_step_post_get_source() {
	# Check whether it is ABI compatible with previous version
	# Should revbump ffmpeg if ABI is changed
	local abi=9
	local encabi=39
	local decabi=12

	mkdir -p termux-abi-test
	( # build the ABI test in a subshell to isolate the `cd`.
		cd termux-abi-test && \
		gcc "$CLANDRO_PKG_BUILDER_DIR"/abi-test.c -o abi-test -I../
		local abi_got eabi_got dabi_got
		IFS=' ' read -r abi_got eabi_got dabi_got < <(./abi-test)
		if [[ "$abi_got $eabi_got $dabi_got" != "$abi $encabi $decabi" ]]; then
			clandro_error_exit "ABI version mismatch in libvpx, got $abi_got $eabi_got $dabi_got."
		fi
	)
	rm -rf termux-abi-test
}

clandro_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Force fresh install of header files:
	rm -rf "$CLANDRO_PREFIX/include/vpx"

	local -a _CONFIGURE_TARGET=()
	case "$CLANDRO_ARCH" in
		"aarch64") _CONFIGURE_TARGET=("--force-target=arm64-v8a-android-gcc");;
		"arm")     _CONFIGURE_TARGET=("--target=armv7-android-gcc" "--disable-neon-asm");;
		"i686")    _CONFIGURE_TARGET=("--target=x86-android-gcc");;
		"x86_64")  _CONFIGURE_TARGET=("--target=x86_64-android-gcc");;
		*) clandro_error_exit "Unsupported arch: $CLANDRO_ARCH";;
	esac

	# For --disable-realtime-only, see
	# https://bugs.chromium.org/p/webm/issues/detail?id=800
	# "The issue is that on android we soft enable realtime only.
	#  [..] You can enable non-realtime by setting --disable-realtime-only"
	# Discovered in https://github.com/termux/termux-packages/issues/554
	#CROSS=${CLANDRO_HOST_PLATFORM}- CC=clang CXX=clang++ $CLANDRO_PKG_SRCDIR/configure \
	"$CLANDRO_PKG_SRCDIR/configure" \
		"${_CONFIGURE_TARGET[@]}" \
		--prefix="$CLANDRO_PREFIX" \
		--disable-examples \
		--disable-realtime-only \
		--disable-unit-tests \
		--enable-pic \
		--enable-postproc \
		--enable-vp8 \
		--enable-vp9 \
		--enable-vp9-highbitdepth \
		--enable-vp9-temporal-denoising \
		--enable-vp9-postproc \
		--enable-shared \
		--enable-small \
		--as=auto \
		--extra-cflags="-fPIC"
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local f
	local -a _SOVERSION_GUARD_FILES=("lib/libvpx.so.12")
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		if [[ ! -e "${f}" ]]; then
			clandro_error_exit "file ${f} not found; please check if SOVERSION has changed."
		fi
	done
}
