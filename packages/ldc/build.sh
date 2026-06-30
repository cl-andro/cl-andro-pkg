CLANDRO_PKG_HOMEPAGE=https://github.com/ldc-developers/ldc
CLANDRO_PKG_DESCRIPTION="D programming language compiler, built with LLVM"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(1.30.0)
CLANDRO_PKG_VERSION+=(14.0.3)  # LLVM version
CLANDRO_PKG_VERSION+=(2.100.1) # TOOLS version
CLANDRO_PKG_VERSION+=(1.30.0)  # DUB version
CLANDRO_PKG_VERSION+=(14.0.21)  # SPIRV-LLVM-Translator version
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=(https://github.com/ldc-developers/ldc/releases/download/v${CLANDRO_PKG_VERSION}/ldc-${CLANDRO_PKG_VERSION}-src.tar.gz
                   https://github.com/ldc-developers/llvm-project/releases/download/ldc-v${CLANDRO_PKG_VERSION[1]}/llvm-${CLANDRO_PKG_VERSION[1]}.src.tar.xz
                   https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANDRO_PKG_VERSION[1]}/libunwind-${CLANDRO_PKG_VERSION[1]}.src.tar.xz
                   https://github.com/dlang/tools/archive/refs/tags/v${CLANDRO_PKG_VERSION[2]}.tar.gz
                   https://github.com/dlang/dub/archive/refs/tags/v${CLANDRO_PKG_VERSION[3]}.tar.gz
                   https://github.com/ldc-developers/ldc/releases/download/v${CLANDRO_PKG_VERSION}/ldc2-${CLANDRO_PKG_VERSION}-linux-x86_64.tar.xz
                   https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/refs/tags/v${CLANDRO_PKG_VERSION[4]}.tar.gz)
CLANDRO_PKG_SHA256=(fdbb376f08242d917922a6a22a773980217fafa310046fc5d6459490af23dacd
                   9638d8d0b6a43d9cdc53699bec19e6bc9bef98f5950b99e6b8c1ec373aee4fa7
                   301137841d1e3401f59b3828d2a9ac86a1b826b89265d55541a2fd6ca2a595eb
                   54bde9a979d70952690a517f90de8d76631fa9a2f7252af7278dafbcaaa42d54
                   840cd65bf5f0dd06ca688f63b94d71fccd92b526bbf1d3892fe5535b1e85c10e
                   5784d4cc47d0845af0897d3b7473a08dd0281a4cdabac0a486740840d014fde1
                   47951817c2fcc1bb8911d288d42d7ddda1771fe58c29ffd6cf6671056145be22)
CLANDRO_PKG_AUTO_UPDATE=false
# dub dlopen()s libcurl.so:
CLANDRO_PKG_DEPENDS="binutils, clang, libc++, libcurl, zlib"
CLANDRO_PKG_BUILD_DEPENDS="binutils-cross"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_FORCE_CMAKE=true
#These CMake args are only used to configure a patched LLVM
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DLLVM_ENABLE_PLUGINS=OFF
-DLLVM_BUILD_TOOLS=OFF
-DLLVM_BUILD_UTILS=OFF
-DLLVM_ENABLE_UNWIND_TABLES=OFF
-DLLVM_ENABLE_TERMINFO=OFF
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_INCLUDE_BENCHMARKS=OFF
-DCOMPILER_RT_INCLUDE_TESTS=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DLLVM_TABLEGEN=$CLANDRO_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DLLVM_CONFIG_PATH=$CLANDRO_PKG_HOSTBUILD_DIR/bin/llvm-config
-DPYTHON_EXECUTABLE=$(command -v python3)
-DLLVM_TARGETS_TO_BUILD='AArch64;ARM;WebAssembly;X86'
"

clandro_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	mv llvm-${CLANDRO_PKG_VERSION[1]}.src llvm
	mv libunwind-${CLANDRO_PKG_VERSION[1]}.src libunwind
	mv tools-${CLANDRO_PKG_VERSION[2]} dlang-tools
	mv dub-${CLANDRO_PKG_VERSION[3]} dub

	# replace SPIRV-LLVM-Translator with more updated version to prevent:
	# spirv_internal.hpp:185:28: error: constexpr variable
	# 'MemoryAccessAliasScopeINTELMask' must be initialized by a constant expression
	rm -rf llvm/projects/SPIRV-LLVM-Translator
	mv "SPIRV-LLVM-Translator-${CLANDRO_PKG_VERSION[4]}" llvm/projects/SPIRV-LLVM-Translator

	# Exclude MLIR
	rm -Rf llvm/projects/mlir

	LLVM_TRIPLE=${CLANDRO_HOST_PLATFORM/-/--}
	if [ $CLANDRO_ARCH = arm ]; then LLVM_TRIPLE=${LLVM_TRIPLE/arm-/armv7a-}; fi
}

_setup_cmake_3() {
	local CLANDRO_CMAKE_VERSION=3.31.10
	local CLANDRO_CMAKE_SHA256=3cb3dd247b6a1de2d0f4b20c6fd4326c9024e894cebc9dc8699758887e566ca7
	local CLANDRO_CMAKE_MAJORVERSION="${CLANDRO_CMAKE_VERSION%.*}"
	local CLANDRO_CMAKE_TARNAME="cmake-${CLANDRO_CMAKE_VERSION}-linux-x86_64.tar.gz"
	local CLANDRO_CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v${CLANDRO_CMAKE_VERSION}/${CLANDRO_CMAKE_TARNAME}"
	local CLANDRO_CMAKE_TARFILE="${CLANDRO_PKG_TMPDIR}/${CLANDRO_CMAKE_TARNAME}"
	local CLANDRO_CMAKE_FOLDER="${CLANDRO_PKG_TMPDIR}/cmake-${CLANDRO_CMAKE_VERSION}"

	local CLANDRO_CMAKE_NAME="cmake"

	if [[ ! -d "${CLANDRO_CMAKE_FOLDER}" ]]; then
		clandro_download "${CLANDRO_CMAKE_URL}" \
			"${CLANDRO_CMAKE_TARFILE}" \
			"${CLANDRO_CMAKE_SHA256}"
		rm -Rf "${CLANDRO_PKG_TMPDIR}/cmake-${CLANDRO_CMAKE_VERSION}-linux-x86_64"
		tar xf "${CLANDRO_CMAKE_TARFILE}" -C "${CLANDRO_PKG_TMPDIR}"
		mv "${CLANDRO_PKG_TMPDIR}/cmake-${CLANDRO_CMAKE_VERSION}-linux-x86_64" \
			"${CLANDRO_CMAKE_FOLDER}"
	fi

	export CMAKE_INSTALL_ALWAYS=1

	export PATH="${CLANDRO_CMAKE_FOLDER}/bin:${PATH}"
}

clandro_step_host_build() {
	# LDC for Android is stuck at version 1.30.0, which is hardcoded to require CMake 3
	_setup_cmake_3
	clandro_setup_ninja

	# Build native llvm-tblgen, a prerequisite for cross-compiling LLVM
	cmake -GNinja $CLANDRO_PKG_SRCDIR/llvm \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_BUILD_TOOLS=OFF \
		-DLLVM_BUILD_UTILS=OFF \
		-DLLVM_INCLUDE_BENCHMARKS=OFF \
		-DCOMPILER_RT_INCLUDE_TESTS=OFF \
		-DLLVM_INCLUDE_TESTS=OFF
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES llvm-tblgen
}

# Just before CMake invokation for LLVM:
clandro_step_pre_configure() {
	# LDC for Android is stuck at version 1.30.0, which is hardcoded to require CMake 3
	_setup_cmake_3
	clandro_setup_ninja
	export PATH="$CLANDRO_PREFIX/opt/binutils/cross/$CLANDRO_HOST_PLATFORM/bin:$PATH"

	LLVM_INSTALL_DIR=$CLANDRO_PKG_BUILDDIR/llvm-install
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_PREFIX=$LLVM_INSTALL_DIR"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_INCLUDEDIR=$LLVM_INSTALL_DIR/include"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_LIBDIR=$LLVM_INSTALL_DIR/lib"

	if [ "$CLANDRO_ARCH" == "arm" ]; then
		# [...]/ldc/src/llvm/projects/compiler-rt/lib/builtins/clear_cache.c:85:20:
		# error: write to reserved register 'R7'
		#   __asm __volatile("svc 0x0"
		#                    ^
		CFLAGS="${CFLAGS//-mthumb/}"
	fi
	LDFLAGS=" -L$CLANDRO_PKG_BUILDDIR/llvm/lib $LDFLAGS -lc++_shared"

	# Don't build compiler-rt sanitizers:
	# * 64-bit targets: libclang_rt.hwasan-*-android.so fails to link
	# * 32-bit targets: compile errors for interception library
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCOMPILER_RT_BUILD_SANITIZERS=OFF -DCOMPILER_RT_BUILD_MEMPROF=OFF"

	local LLVM_TARGET_ARCH
	if [ $CLANDRO_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $CLANDRO_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $CLANDRO_ARCH = "i686" ]; then
		LLVM_TARGET_ARCH=X86
	elif [ $CLANDRO_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		clandro_error_exit "Invalid arch: $CLANDRO_ARCH"
	fi
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_DEFAULT_TARGET_TRIPLE=${LLVM_TRIPLE}"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=${LLVM_TARGET_ARCH}"

	# CPPFLAGS adds the system llvm to the include path, which causes
	# conflicts with the local patched llvm when compiling ldc
	CPPFLAGS=""

	OLD_TERMUX_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR
	CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR/llvm

	OLD_TERMUX_PKG_BUILDDIR=$CLANDRO_PKG_BUILDDIR
	CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_BUILDDIR/llvm
	mkdir "$CLANDRO_PKG_BUILDDIR"
}

clandro_step_configure() {
	# skip clandro_setup_cmake which would install cmake 4 into $PATH
	clandro_step_configure_cmake
}

# CMake for LLVM has been run:
clandro_step_post_configure() {
	# Cross-compile & install LLVM
	cd "$CLANDRO_PKG_BUILDDIR"
	if test -f build.ninja; then
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES install
	fi

	# Invoke CMake for LDC:

	CLANDRO_PKG_SRCDIR=$OLD_TERMUX_PKG_SRCDIR
	CLANDRO_PKG_BUILDDIR=$OLD_TERMUX_PKG_BUILDDIR
	cd "$CLANDRO_PKG_BUILDDIR"

	# Replace non-native llvm-config executable with bash script,
	# as it is going to be invoked during LDC CMake config.
	sed $CLANDRO_PKG_SRCDIR/.github/actions/3-build-cross/android-llvm-config.in \
		-e "s|@LLVM_VERSION@|${CLANDRO_PKG_VERSION[1]}|g" \
		-e "s|@LLVM_INSTALL_DIR@|$LLVM_INSTALL_DIR|g" \
		-e "s|@CLANDRO_PKG_SRCDIR@|$CLANDRO_PKG_SRCDIR/llvm|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_TRIPLE|g" \
		-e "s|@LLVM_TARGETS@|AArch64 ARM X86 WebAssembly|g" > $LLVM_INSTALL_DIR/bin/llvm-config
	chmod 755 $LLVM_INSTALL_DIR/bin/llvm-config

	LDC_FLAGS="-mtriple=$LLVM_TRIPLE"

	LDC_PATH=$CLANDRO_PKG_SRCDIR/ldc2-$CLANDRO_PKG_VERSION-linux-x86_64
	DMD=$LDC_PATH/bin/ldmd2

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS=" -DLLVM_ROOT_DIR=$LLVM_INSTALL_DIR \
		-DD_COMPILER=$DMD \
		-DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX \
		-DLDC_WITH_LLD=OFF \
		-DLDC_INSTALL_LLVM_RUNTIME_LIBS_OS=android \
		-DLDC_INSTALL_LLVM_RUNTIME_LIBS_ARCH=$CLANDRO_ARCH-android \
		-DD_LINKER_ARGS='-fuse-ld=bfd;-Lldc-build-runtime.tmp/lib;-lphobos2-ldc;-ldruntime-ldc;-Wl,--gc-sections'"

	clandro_step_configure_cmake
}

clandro_step_make() {
	# Cross-compile the runtime libraries
	$LDC_PATH/bin/ldc-build-runtime --ninja -j $CLANDRO_PKG_MAKE_PROCESSES \
		--dFlags="-fvisibility=hidden;$LDC_FLAGS" \
		--cFlags="-I$CLANDRO_PREFIX/include" \
		--targetSystem="Android;Linux;UNIX" \
		--ldcSrcDir="$CLANDRO_PKG_SRCDIR"

	# Set up host ldmd2 for cross-compilation
	export DFLAGS="${LDC_FLAGS//;/ }"

	# Cross-compile LDC executables (linked against runtime libs above)
	if test -f build.ninja; then
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES ldc2 ldmd2 ldc-build-runtime ldc-profdata ldc-prune-cache
	fi
	echo ".: LDC built successfully."

	# Cross-compile dlang tools and dub:

	# Extend DFLAGS for cross-linking with host ldmd2
	export DFLAGS="$DFLAGS -linker=bfd -L-L$CLANDRO_PKG_BUILDDIR/ldc-build-runtime.tmp/lib"
	if [ $CLANDRO_ARCH = arm ]; then export DFLAGS="$DFLAGS -L--fix-cortex-a8"; fi

	# https://github.com/termux/termux-packages/issues/7188
	DFLAGS+=" -L--enable-new-dtags -L-rpath=$CLANDRO_PREFIX/lib"

	cd  $CLANDRO_PKG_SRCDIR/dlang-tools
	$DMD -w -de -dip1000 rdmd.d -of=$CLANDRO_PKG_BUILDDIR/bin/rdmd
	$DMD -w -de -dip1000 ddemangle.d -of=$CLANDRO_PKG_BUILDDIR/bin/ddemangle
	$DMD -w -de -dip1000 DustMite/dustmite.d DustMite/splitter.d DustMite/polyhash.d -of=$CLANDRO_PKG_BUILDDIR/bin/dustmite
	echo ".: dlang tools built successfully."

	cd $CLANDRO_PKG_SRCDIR/dub
	# Note: cannot link a native build.d tool, so build manually:
	$DMD -of=$CLANDRO_PKG_BUILDDIR/bin/dub -Isource -version=DubUseCurl -version=DubApplication -O -w -linkonce-templates @build-files.txt
	echo ".: dub built successfully."
}

clandro_step_make_install() {
	cp bin/{ddemangle,dub,dustmite,ldc-build-runtime,ldc-profdata,ldc-prune-cache,ldc2,ldmd2,rdmd} $CLANDRO_PREFIX/bin
	cp $CLANDRO_PKG_BUILDDIR/ldc-build-runtime.tmp/lib/*.a $CLANDRO_PREFIX/lib
	cp lib/libldc_rt.* $CLANDRO_PREFIX/lib || true
	sed "s|$CLANDRO_PREFIX/|%%ldcbinarypath%%/../|g" bin/ldc2_install.conf > $CLANDRO_PREFIX/etc/ldc2.conf

	rm -Rf $CLANDRO_PREFIX/include/d
	mkdir $CLANDRO_PREFIX/include/d
	cp -r $CLANDRO_PKG_SRCDIR/runtime/druntime/src/{core,etc,ldc,object.d} $CLANDRO_PREFIX/include/d
	cp $LDC_PATH/import/ldc/gccbuiltins_{aarch64,arm,x86}.di $CLANDRO_PREFIX/include/d/ldc
	cp -r $CLANDRO_PKG_SRCDIR/runtime/phobos/etc/c $CLANDRO_PREFIX/include/d/etc
	rm -Rf $CLANDRO_PREFIX/include/d/etc/c/zlib
	cp -r $CLANDRO_PKG_SRCDIR/runtime/phobos/std $CLANDRO_PREFIX/include/d

	rm -Rf $CLANDRO_PREFIX/share/ldc
	mkdir $CLANDRO_PREFIX/share/ldc
	cp -r $CLANDRO_PKG_SRCDIR/{LICENSE,README,packaging/bash_completion.d} $CLANDRO_PREFIX/share/ldc
}
