CLANDRO_PKG_HOMEPAGE=https://github.com/exaloop/codon
CLANDRO_PKG_DESCRIPTION="A high-performance, zero-overhead, extensible Python compiler using LLVM"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_LLVM_VERSION=20.1.7
CLANDRO_PKG_VERSION="0.19.6"
TERMUx_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(
	https://github.com/exaloop/codon/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
	https://github.com/exaloop/codon/releases/download/v$CLANDRO_PKG_VERSION/codon-linux-x86_64.tar.gz
	https://github.com/exaloop/llvm-project/archive/refs/tags/codon-$_LLVM_VERSION.tar.gz
)
CLANDRO_PKG_SHA256=(
	e33deefaf7ff3518c838db22d92b31f28cff4675a7ece70b79d5d31be1ce7420
	38befce9eb87244698014b1fbe56a4102660120f1b82b3c7777c2a98c109770a
	09df072c95628d9f59f67e0ad309bd3f4387f8cb06ae115f78c496c34f2c1e98
)
CLANDRO_PKG_DEPENDS="libc++, libxml2, zlib, zstd"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

# Args for the bundled LLVM
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_PLATFORM_LEVEL=$CLANDRO_PKG_API_LEVEL
-DPYTHON_EXECUTABLE=$(command -v python3)
-DLLVM_ENABLE_PIC=ON
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_LINK_LLVM_DYLIB=on
-DLLVM_NATIVE_TOOL_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/llvm-build/bin
-DCROSS_TOOLCHAIN_FLAGS_LLVM_NATIVE=-DLLVM_NATIVE_TOOL_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/llvm-build/bin
-DLIBOMP_ENABLE_SHARED=ON
-DLLVM_ENABLE_SPHINX=ON
-DSPHINX_OUTPUT_MAN=ON
-DSPHINX_WARNINGS_AS_ERRORS=OFF
-DPERL_EXECUTABLE=$(command -v perl)
-DLLVM_INSTALL_UTILS=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DLLVM_ENABLE_TERMINFO=OFF
-DLLVM_ENABLE_FFI=ON
-DLLVM_ENABLE_RTTI=ON
-DLLVM_ENABLE_ZLIB=OFF
-DLLVM_ENABLE_ZSTD=OFF
-DLLVM_TARGETS_TO_BUILD=all
-DLLVM_ENABLE_PROJECTS=clang;openmp
"
CLANDRO_PKG_FORCE_CMAKE=true

# codon ships its own libomp.so
CLANDRO_PKG_NO_OPENMP_CHECK=true

# On ARM and i686, codon crashes:
# JIT session error: Unsupported target machine architecture in ELF object codon-jitted-objectbuffer
# Failure value returned from cantFail wrapped call
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_post_get_source() {
	# Check llvm version
	local _llvm_version="$(strings codon-deploy-linux-x86_64/bin/codon | grep 'clang version' | cut -d' ' -f3)"
	if [ "$_LLVM_VERSION" != "$_llvm_version" ]; then
		clandro_error_exit "LLVM version mismatch: current $_LLVM_VERSION, expected $_llvm_version."
	fi
	mv llvm-project-codon-"$_llvm_version" llvm-project
}

clandro_step_pre_configure() {
	# This can't be set in the global scope because $CLANDRO_PREFIX
	# is not set here during auto update checks here.
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DDEFAULT_SYSROOT=$(dirname "$CLANDRO_PREFIX")"
}

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	# Compile llvm host tools
	mkdir -p llvm-build
	cd llvm-build
	cmake -G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_ENABLE_PROJECTS=clang \
		"$CLANDRO_PKG_SRCDIR"/llvm-project/llvm
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES llvm-tblgen llvm-min-tblgen clang-tblgen
	cd -

	# Compile peg2cpp
	mkdir -p peg2cpp-build
	cd peg2cpp-build
	cp -f "$CLANDRO_PKG_SRCDIR"/codon/util/peg2cpp.cpp ./peg2cpp.cpp
	cp -f "$CLANDRO_PKG_BUILDER_DIR"/host-peg2cpp-CMakeLists.txt ./CMakeLists.txt
	cmake -G Ninja .
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES peg2cpp
}

__codon_build_llvm() {
	export _CODON_LLVM_INSTALL_DIR="$CLANDRO_PKG_BUILDDIR"/llvm-install
	if [ -f "$_CODON_LLVM_INSTALL_DIR"/.codon-llvm-built ]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	# Add unknown vendor, otherwise it screws with the default LLVM triple
	# detection.
	export LLVM_DEFAULT_TARGET_TRIPLE=${CCCLANDRO_HOST_PLATFORM/-/-unknown-}
	export LLVM_TARGET_ARCH
	if [ $CLANDRO_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $CLANDRO_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $CLANDRO_ARCH = "i686" ] || [ $CLANDRO_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		clandro_error_exit "Invalid arch: $CLANDRO_ARCH"
	fi
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_PREFIX=$_CODON_LLVM_INSTALL_DIR"

	# Backup dirs
	local __old_srcdir="$CLANDRO_PKG_SRCDIR"
	local __old_builddir="$CLANDRO_PKG_BUILDDIR"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR"/llvm-project/llvm
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_BUILDDIR"/llvm-build

	# Configure
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure_cmake

	# Cross-compile & install LLVM
	cd "$CLANDRO_PKG_BUILDDIR"
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES install

	# Recover dirs
	CLANDRO_PKG_SRCDIR="$__old_srcdir"
	CLANDRO_PKG_BUILDDIR="$__old_builddir"

	# Mark as built
	mkdir -p "$_CODON_LLVM_INSTALL_DIR"
	touch -f "$_CODON_LLVM_INSTALL_DIR"/.codon-llvm-built
}

clandro_step_configure() {
	__codon_build_llvm

	clandro_setup_cmake
	clandro_setup_ninja

	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/peg2cpp-build:$PATH"
	local _RPATH_FLAG="-Wl,-rpath=$CLANDRO_PREFIX/lib"
	local _RPATH_FLAG_ADD="-Wl,-rpath='\$ORIGIN' -Wl,-rpath='\$ORIGIN/../lib/codon' -Wl,-rpath=$CLANDRO_PREFIX/lib"
	LDFLAGS="${LDFLAGS/$_RPATH_FLAG/$_RPATH_FLAG_ADD}"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DLLVM_DIR=$_CODON_LLVM_INSTALL_DIR/lib/cmake/llvm"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX/opt/codon"
	# CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_ASM_FLAGS=--target=$CCCLANDRO_HOST_PLATFORM"

	if [ "$CLANDRO_ARCH" = "x86_64" ] || [ "$CLANDRO_ARCH" = "i686" ]; then
		export OPENBLAS_CROSS_TARGET="TARGET CORE2"
	fi

	cd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure_cmake
}

clandro_step_post_make_install() {
	# Create start script
	cat << EOF > $CLANDRO_PREFIX/bin/codon
#!$CLANDRO_PREFIX/bin/env sh

export PATH="$CLANDRO_PREFIX/opt/codon/bin:\$PATH"
exec $CLANDRO_PREFIX/opt/codon/bin/codon "\$@"

EOF
	chmod +x $CLANDRO_PREFIX/bin/codon
}

clandro_step_post_massage() {
	# Remove some unrelated includes and libraries
	rm -rf include lib
}
