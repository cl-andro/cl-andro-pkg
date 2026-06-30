CLANDRO_PKG_HOMEPAGE=https://flang.llvm.org/
CLANDRO_PKG_DESCRIPTION="LLVM's Fortran frontend"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="flang/LICENSE.TXT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="21.1.8"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=(
	"https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANDRO_PKG_VERSION}/llvm-project-${CLANDRO_PKG_VERSION}.src.tar.xz"
	"https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANDRO_PKG_VERSION}/LLVM-${CLANDRO_PKG_VERSION}-Linux-X64.tar.xz"
)
CLANDRO_PKG_SHA256=(
	4633a23617fa31a3ea51242586ea7fb1da7140e426bd62fc164261fe036aa142
	b3b7f2801d15d50736acea3c73982994d025b01c2f035b91ae3b49d1b575732b
)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_HOSTBUILD=true
# `flang-new` should be rebuilt when libllvm bumps version.
# See https://github.com/termux/termux-packages/issues/19362
dep_qualifier="$CLANDRO_PKG_VERSION-$CLANDRO_PKG_REVISION"
CLANDRO_PKG_DEPENDS="libandroid-complex-math-static, libc++, libllvm (= $dep_qualifier), clang (= $dep_qualifier), lld (= $dep_qualifier), mlir (= $dep_qualifier)"
CLANDRO_PKG_BUILD_DEPENDS="libllvm-static"
unset dep_qualifier

# Upstream doesn't support 32-bit arches well. See https://github.com/llvm/llvm-project/issues/57621.
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

# See http://llvm.org/docs/CMake.html:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DLLVM_ENABLE_PIC=ON
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_TARGETS_TO_BUILD=all
-DLLVM_ENABLE_FFI=ON
-DFLANG_DEFAULT_LINKER=lld
-DMLIR_INSTALL_AGGREGATE_OBJECTS=OFF
-DFLANG_INCLUDE_TESTS=OFF
-DLLVM_ENABLE_ASSERTIONS=ON
-DLLVM_LIT_ARGS=-v
-DLLVM_DIR=$CLANDRO_PREFIX/lib/cmake/llvm
-DCLANG_DIR=$CLANDRO_PREFIX/lib/cmake/clang
-DMLIR_DIR=$CLANDRO_PREFIX/lib/cmake/mlir
-DMLIR_TABLEGEN_EXE=$CLANDRO_PKG_HOSTBUILD_DIR/bin/mlir-tblgen
-DLLVM_NATIVE_TOOL_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/bin
-DCROSS_TOOLCHAIN_FLAGS_LLVM_NATIVE=-DLLVM_NATIVE_TOOL_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/bin
"
# -DDEFAULT_SYSROOT=$(dirname $CLANDRO_PREFIX)

if (( CLANDRO_ARCH_BITS == 32 )); then
	# Do not set _FILE_OFFSET_BITS=64
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_FORCE_SMALLFILE_FOR_ANDROID=on"
fi

CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_HAS_DEBUG=false
CLANDRO_PKG_NO_STATICSPLIT=true

# shellcheck disable=SC2030,2031
clandro_step_post_get_source() {
	# Version guard to keep flang in sync
	local llvm_version llvm_revision
	llvm_version="$(. "$CLANDRO_SCRIPTDIR/packages/libllvm/build.sh"; echo "${CLANDRO_PKG_VERSION}")"
	llvm_revision="$(CLANDRO_PKG_REVISION=0; . "$CLANDRO_SCRIPTDIR/packages/libllvm/build.sh"; echo "${CLANDRO_PKG_REVISION}")"
	if [[ "${llvm_version}-${llvm_revision}" != "${CLANDRO_PKG_VERSION}-${CLANDRO_PKG_REVISION:-0}" ]]; then
		clandro_error_exit "Version mismatch between libllvm and flang. flang=$CLANDRO_PKG_VERSION-$CLANDRO_PKG_REVISION, libllvm=$llvm_version-$llvm_revision"
	fi
}

# shellcheck disable=SC2031
clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake -G Ninja "-DCMAKE_BUILD_TYPE=Release" \
					"-DLLVM_ENABLE_PROJECTS=clang;mlir" \
					"$CLANDRO_PKG_SRCDIR/llvm"
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES" clang-tblgen mlir-tblgen
}

# shellcheck disable=SC2031
clandro_step_pre_configure() {
	local default_sysroot
	if [[ "$CLANDRO__PREFIX" == "$CLANDRO__ROOTFS" ]]; then
		default_sysroot=".."
	else
		default_sysroot="../.."
	fi
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DDEFAULT_SYSROOT=$default_sysroot"
}

# shellcheck disable=SC2030,2031
__flang_build_runtime() {
	if [[ -f "$CLANDRO_PKG_BUILDDIR"/.flang-rt-built ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	# Add target to flang
	mkdir -p "$CLANDRO_PKG_TMPDIR/flang-bin"
	cat <<- EOF > "$CLANDRO_PKG_TMPDIR/flang-bin/${CLANDRO_HOST_PLATFORM}-flang-new"
	#!/usr/bin/env bash
	if [[ "\$1" != "-cpp" && "\$1" != "-fc1" ]]; then
		"$CLANDRO_PKG_SRCDIR/LLVM-$CLANDRO_PKG_VERSION-Linux-X64/bin/flang-new" --target="${CLANDRO_HOST_PLATFORM}${CLANDRO_PKG_API_LEVEL}" -D__ANDROID_API__="$CLANDRO_PKG_API_LEVEL" "\$@"
	else
		# Target is already an argument.
		"$CLANDRO_PKG_SRCDIR/LLVM-$CLANDRO_PKG_VERSION-Linux-X64/bin/flang-new" "\$@"
	fi
	EOF
	chmod u+x "$CLANDRO_PKG_TMPDIR/flang-bin/${CLANDRO_HOST_PLATFORM}-flang-new"

	( # Use a subshell to not effect the values outside this function
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR/runtimes"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_BUILDDIR"/flang-rt-build
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLANG_VERSION_MAJOR=${CLANDRO_PKG_VERSION%%.*}"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_ENABLE_RUNTIMES=flang-rt"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_Fortran_COMPILER=$CLANDRO_PKG_TMPDIR/flang-bin/${CLANDRO_HOST_PLATFORM}-flang-new"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_Fortran_COMPILER_WORKS=yes"

	# Configure
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR" && \
	clandro_step_configure_cmake

	# Cross-compile Flang runtime
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES"
	)

	# Mark as built
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	touch -f "$CLANDRO_PKG_BUILDDIR"/.flang-rt-built
}

# shellcheck disable=SC2031
clandro_step_configure() {
	# Add unknown vendor, otherwise it screws with the default LLVM triple detection.
	export LLVM_DEFAULT_TARGET_TRIPLE="${CCCLANDRO_HOST_PLATFORM/-/-unknown-}"

	# Compile flang-rt
	__flang_build_runtime

	clandro_setup_cmake
	clandro_setup_ninja

	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/bin:$PATH"
	# see CMakeLists.txt and tools/clang/CMakeLists.txt
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"

	local __old_srcdir="$CLANDRO_PKG_SRCDIR"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR/flang"

	clandro_step_configure_cmake
	CLANDRO_PKG_SRCDIR="$__old_srcdir"

	# Avoid the possible OOM
	CLANDRO_PKG_MAKE_PROCESSES=1
}

# shellcheck disable=SC2031
clandro_step_post_make_install() {
	# Install flang-rt
	cp -f "$CLANDRO_PKG_BUILDDIR"/flang-rt-build/flang-rt/lib/libflang_rt.runtime.a \
		"$CLANDRO_PREFIX"/lib/libflang_rt.runtime.a

	# Copy module source files
	mkdir -p "$CLANDRO_PREFIX/opt/flang"/{include,module}
	cp -f "$CLANDRO_PKG_SRCDIR/flang/module"/* "$CLANDRO_PREFIX/opt/flang/module/"
	ln -sf "$CLANDRO_PREFIX/include/flang" "$CLANDRO_PREFIX/opt/flang/include/"
}

clandro_step_create_debscripts() {
	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		"$CLANDRO_PKG_BUILDER_DIR/postinst.sh.in" > ./postinst
	chmod +x ./postinst

	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		"$CLANDRO_PKG_BUILDER_DIR/prerm.sh.in" > ./prerm
	chmod +x ./prerm
}
