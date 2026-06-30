CLANDRO_PKG_HOMEPAGE=http://x265.org/
CLANDRO_PKG_DESCRIPTION="H.265/HEVC video stream encoder library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2"
CLANDRO_PKG_SRCURL=https://bitbucket.org/multicoreware/x265_git/downloads/x265_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=40b1ea0453e0309f0eba934e0ddf533f8f6295966679e8894e8f1c1c8d5e1210
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-posix-semaphore, libc++"
CLANDRO_PKG_BREAKS="libx265-dev"
CLANDRO_PKG_REPLACES="libx265-dev"

clandro_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=216

	local v=$(sed -En 's/^.*set\(X265_BUILD ([0-9]+).*$/\1/p' \
			source/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi

	local _TERMUX_CLANG_TARGET=

	# Not sure if this is necessary for on-device build
	# Follow clandro_step_configure_cmake.sh for now
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		_TERMUX_CLANG_TARGET="--target=${CCCLANDRO_HOST_PLATFORM}"
	fi

	if [[ "$CLANDRO_ARCH" = arm || "$CLANDRO_ARCH" = i686 ]]; then
		# Avoid text relocations and/or build failure.
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DENABLE_ASSEMBLY=OFF"
	fi

	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR/source"

	sed -i "s/@CLANDRO_CLANG_TARGET_${CLANDRO_ARCH^^}@/${_TERMUX_CLANG_TARGET}/" \
		${CLANDRO_PKG_SRCDIR}/CMakeLists.txt

	LDFLAGS+=" -landroid-posix-semaphore"
}

clandro_step_configure() {
	clandro_setup_cmake
	clandro_setup_ninja

	if [[ "$CLANDRO_ARCH_BITS" == "32" ]]; then
		pushd "$CLANDRO_PKG_BUILDDIR"
		clandro_step_configure_cmake
		popd
		return
	fi

	# build multiple bit depth modes into a single library by copying how Arch Linux does it
	# https://gitlab.archlinux.org/archlinux/packaging/packages/x265/-/blob/3761f9fb296071fc81dc1c74861fb9f6a94aa8ba/PKGBUILD#L49
	# note: -DHIGH_BIT_DEPTH=ON and -DMAIN12=ON have no effect on 32-bit targets
	# https://bitbucket.org/multicoreware/x265_git/src/9e551a994f970a24f0e49bcebe3d43ef08448b01/source/CMakeLists.txt#lines-690
	local original_options=(
	"$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS"
	-DENABLE_HDR10_PLUS=ON
	-DCMAKE_POLICY_VERSION_MINIMUM=3.5
	)
	local tenbit_options=(
	"${original_options[@]}"
	-DENABLE_CLI=OFF
	-DENABLE_SHARED=OFF
	-DEXPORT_C_API=OFF
	-DHIGH_BIT_DEPTH=ON
	)
	local twelvebit_options=(
	"${tenbit_options[@]}"
	-DMAIN12=ON
	)
	local final_options=(
	"${original_options[@]}"
	-DENABLE_SHARED=ON
	-DEXTRA_LIB='x265_main10.a;x265_main12.a'
	-DEXTRA_LINK_FLAGS="-L$CLANDRO_PKG_BUILDDIR"
	-DLINKED_10BIT=ON
	-DLINKED_12BIT=ON
	)

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="${tenbit_options[@]}"
	mkdir -p "$CLANDRO_PKG_BUILDDIR/10bit_build"
	pushd "$CLANDRO_PKG_BUILDDIR/10bit_build"
	clandro_step_configure_cmake
	popd

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="${twelvebit_options[@]}"
	mkdir -p "$CLANDRO_PKG_BUILDDIR/12bit_build"
	pushd "$CLANDRO_PKG_BUILDDIR/12bit_build"
	clandro_step_configure_cmake
	popd

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="${final_options[@]}"
	pushd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure_cmake
	popd
}

clandro_step_make() {
	if [[ "$CLANDRO_ARCH_BITS" == "32" ]]; then
		cmake --build "$CLANDRO_PKG_BUILDDIR"
		return
	fi

	cmake --build "$CLANDRO_PKG_BUILDDIR/10bit_build"
	cmake --build "$CLANDRO_PKG_BUILDDIR/12bit_build"
	ln -sfr "$CLANDRO_PKG_BUILDDIR/10bit_build/libx265.a" "$CLANDRO_PKG_BUILDDIR/libx265_main10.a"
	ln -sfr "$CLANDRO_PKG_BUILDDIR/12bit_build/libx265.a" "$CLANDRO_PKG_BUILDDIR/libx265_main12.a"
	cmake --build "$CLANDRO_PKG_BUILDDIR"
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
