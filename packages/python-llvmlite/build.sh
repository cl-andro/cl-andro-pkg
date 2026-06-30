CLANDRO_PKG_HOMEPAGE=https://llvmlite.pydata.org/
CLANDRO_PKG_DESCRIPTION="A lightweight LLVM python binding for writing JIT compilers"
# LICENSES: BSD 2-Clause, Apache-2.0 with LLVM Exceptions
CLANDRO_PKG_LICENSE="BSD 2-Clause, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.thirdparty"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(
	"0.47.0"
	"20.1.8"
)
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=(
	"https://github.com/numba/llvmlite/archive/refs/tags/v${CLANDRO_PKG_VERSION[0]}.tar.gz"
	"https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANDRO_PKG_VERSION[1]}/llvm-project-${CLANDRO_PKG_VERSION[1]}.src.tar.xz"
)
CLANDRO_PKG_SHA256=(
	819a4db56e0983f9106734a07732238b55783bac654a2365c47f4c35f3c96ba2
	6898f963c8e938981e6c4a302e83ec5beb4630147c7311183cf61069af16333d
)
CLANDRO_PKG_DEPENDS="libc++, libffi, python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true

# See http://llvm.org/docs/CMake.html:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_PLATFORM_LEVEL=$CLANDRO_PKG_API_LEVEL
-DPYTHON_EXECUTABLE=$(command -v python3)
-DLLVM_ENABLE_PIC=ON
-DLLVM_INCLUDE_TESTS=OFF
-DDEFAULT_SYSROOT=$(dirname "$CLANDRO_PREFIX")
-DLLVM_NATIVE_TOOL_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/bin
-DCROSS_TOOLCHAIN_FLAGS_LLVM_NATIVE=-DLLVM_NATIVE_TOOL_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/bin
-DLIBOMP_ENABLE_SHARED=FALSE
-DLLVM_ENABLE_SPHINX=ON
-DSPHINX_OUTPUT_MAN=ON
-DSPHINX_WARNINGS_AS_ERRORS=OFF
-DLLVM_TARGETS_TO_BUILD=all
-DPERL_EXECUTABLE=$(command -v perl)
-DLLVM_ENABLE_ZSTD=OFF
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_ENABLE_LIBXML2=OFF
-DLLVM_ENABLE_RTTI=OFF
-DLLVM_ENABLE_TERMINFO=OFF
-DLLVM_INCLUDE_BENCHMARKS=OFF
-DLLVM_INCLUDE_DOCS=OFF
-DLLVM_INCLUDE_EXAMPLES=OFF
-DLLVM_INCLUDE_GO_TESTS=OFF
-DLLVM_INCLUDE_UTILS=ON
-DLLVM_INSTALL_UTILS=ON
-DLLVM_BUILD_LLVM_DYLIB=OFF
-DLLVM_LINK_LLVM_DYLIB=OFF
-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly
-DLLVM_ENABLE_FFI=ON
-DLLVM_ENABLE_Z3_SOLVER=OFF
-DLLVM_OPTIMIZED_TABLEGEN=ON
"

if (( CLANDRO_ARCH_BITS == 32 )); then
	# Do not set _FILE_OFFSET_BITS=64
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_FORCE_SMALLFILE_FOR_ANDROID=on"
fi

clandro_step_post_get_source() {
	mv llvm-project-"${CLANDRO_PKG_VERSION[1]}".src llvm-project
}

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake -G Ninja "-DCMAKE_BUILD_TYPE=Release" \
					"-DLLVM_ENABLE_PROJECTS=clang" \
					"$CLANDRO_PKG_SRCDIR/llvm-project/llvm"
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES" llvm-tblgen clang-tblgen
}

__llvmlite_build_llvm() {
	export _LLVMLITE_LLVM_INSTALL_DIR="$CLANDRO_PKG_BUILDDIR"/llvm-install
	if [[ -f "$_LLVMLITE_LLVM_INSTALL_DIR"/.llvmlite-llvm-built ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	# Add unknown vendor, otherwise it screws with the default LLVM triple
	# detection.
	export LLVM_DEFAULT_TARGET_TRIPLE="${CCCLANDRO_HOST_PLATFORM/-/-unknown-}"
	export LLVM_TARGET_ARCH
	case "$CLANDRO_ARCH" in
		"aarch64") LLVM_TARGET_ARCH=AArch64;;
		"arm") LLVM_TARGET_ARCH=ARM;;
		"i686"|"x86_64") LLVM_TARGET_ARCH=X86;;
		*) clandro_error_exit "Invalid arch: $CLANDRO_ARCH"
	esac
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_PREFIX=$_LLVMLITE_LLVM_INSTALL_DIR"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_INCLUDEDIR=$_LLVMLITE_LLVM_INSTALL_DIR/include"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_LIBDIR=$_LLVMLITE_LLVM_INSTALL_DIR/lib"

	# Backup dirs and envs
	local __old_ldflags="$LDFLAGS"
	local __old_srcdir="$CLANDRO_PKG_SRCDIR"
	local __old_builddir="$CLANDRO_PKG_BUILDDIR"
	LDFLAGS="-Wl,--undefined-version $LDFLAGS"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR"/llvm-project/llvm
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_BUILDDIR"/llvm-build

	# Configure
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR" && \
	clandro_step_configure_cmake

	# Cross-compile & install LLVM
	cd "$CLANDRO_PKG_BUILDDIR" && \
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES" install

	# Recover dirs and envs
	LDFLAGS="$__old_ldflags"
	CLANDRO_PKG_SRCDIR="$__old_srcdir"
	CLANDRO_PKG_BUILDDIR="$__old_builddir"

	# Mark as built
	mkdir -p "$_LLVMLITE_LLVM_INSTALL_DIR"
	touch -f "$_LLVMLITE_LLVM_INSTALL_DIR"/.llvmlite-llvm-built
}

__llvmlite_build_lib() {
	clandro_setup_cmake
	clandro_setup_ninja

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DLLVM_DIR=$_LLVMLITE_LLVM_INSTALL_DIR/lib/cmake/llvm"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_POLICY_VERSION_MINIMUM=3.5"

	# Backup dirs and envs
	local __old_srcdir="$CLANDRO_PKG_SRCDIR"
	local __old_builddir="$CLANDRO_PKG_BUILDDIR"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR"/ffi
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"/build

	# Configure
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR" && \
	clandro_step_configure_cmake

	# Cross-compile llvmlite
	cd "$CLANDRO_PKG_BUILDDIR" && \
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES"

	# Recover dirs and envs
	CLANDRO_PKG_SRCDIR="$__old_srcdir"
	CLANDRO_PKG_BUILDDIR="$__old_builddir"
}

clandro_step_configure() {
	:
}

clandro_step_make() {
	__llvmlite_build_llvm

	__llvmlite_build_lib

	# Copy libs
	cp -f "$CLANDRO_PKG_SRCDIR"/ffi/build/libllvmlite.so "$CLANDRO_PKG_SRCDIR"/llvmlite/binding/
}

clandro_step_make_install() {
	LDFLAGS+=" -Wl,--no-as-needed -lpython${CLANDRO_PYTHON_VERSION}"

	export LLVMLITE_SKIP_BUILD_LIBRARY=1
	pip install . --prefix="$CLANDRO_PREFIX" -vv --no-build-isolation --no-deps
}

clandro_step_post_massage() {
	local dir="include"
	if [[ -d "${CLANDRO_PKG_MASSAGEDIR}${CLANDRO_PREFIX}/$dir" ]]; then
		clandro_error_exit "$dir should not exist in $CLANDRO_PKG_NAME!"
	fi
}
