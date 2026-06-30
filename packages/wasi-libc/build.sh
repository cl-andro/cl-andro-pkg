CLANDRO_PKG_HOMEPAGE=https://wasi.dev/
CLANDRO_PKG_DESCRIPTION="Libc for WebAssembly programs built on top of WASI system calls"
CLANDRO_PKG_LICENSE="Apache-2.0, BSD 2-Clause, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE, src/wasi-libc/LICENSE-MIT, src/wasi-libc/libc-bottom-half/cloudlibc/LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="30"
CLANDRO_PKG_SRCURL=git+https://github.com/WebAssembly/wasi-sdk
CLANDRO_PKG_GIT_BRANCH=wasi-sdk-${CLANDRO_PKG_VERSION}
CLANDRO_PKG_RECOMMENDS="wasm-component-ld"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+"

clandro_step_post_get_source() {
	# match "clang -print-resource-dir"
	local p="${CLANDRO_PKG_BUILDER_DIR}/0001-move-clang-resource-dir.diff"
	echo "Applying patch: $(basename "${p}")"
	sed "s|@LLVM_MAJOR_VERSION@|${CLANDRO_LLVM_MAJOR_VERSION}|g" "${p}" \
		| patch -p1 --silent
}

clandro_step_host_build() {
	# https://github.com/WebAssembly/wasi-sdk/blob/main/CMakeLists.txt
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_rust

	cmake \
		-G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}/toolchain" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="${CLANDRO_PKG_HOSTBUILD_DIR}/install" \
		-DWASI_SDK_BUILD_TOOLCHAIN=ON
	ninja \
		-C "${CLANDRO_PKG_HOSTBUILD_DIR}/toolchain" \
		-j "${CLANDRO_PKG_MAKE_PROCESSES}" \
		install

	cmake \
		-G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}/sysroot" \
		-DCMAKE_C_COMPILER_WORKS=ON \
		-DCMAKE_CXX_COMPILER_WORKS=ON \
		-DCMAKE_INSTALL_PREFIX="${CLANDRO_PREFIX}" \
		-DCMAKE_TOOLCHAIN_FILE="${CLANDRO_PKG_HOSTBUILD_DIR}/install/share/cmake/wasi-sdk.cmake"
	ninja \
		-C "${CLANDRO_PKG_HOSTBUILD_DIR}/sysroot" \
		-j "${CLANDRO_PKG_MAKE_PROCESSES}" \
		install

	# not installed by "ninja install"
	mkdir -p "${CLANDRO_PREFIX}/share/cmake/Platform"
	mv -v "${CLANDRO_PKG_HOSTBUILD_DIR}"/install/share/cmake/Platform/*.cmake "${CLANDRO_PREFIX}/share/cmake/Platform/"
	mv -v "${CLANDRO_PKG_HOSTBUILD_DIR}"/install/share/cmake/*.cmake "${CLANDRO_PREFIX}/share/cmake/"

	local LLVM_MAJOR_VERSION_UPSTREAM
	LLVM_MAJOR_VERSION_UPSTREAM="$(grep llvm-version "${CLANDRO_PREFIX}/share/wasi-sysroot/VERSION" | cut -d" " -f2 | cut -d"." -f1)"
	echo "INFO: LLVM_MAJOR_VERSION_UPSTREAM = $LLVM_MAJOR_VERSION_UPSTREAM"
	echo "INFO: LLVM_MAJOR_VERSION          = $CLANDRO_LLVM_MAJOR_VERSION"
	if [[ "${LLVM_MAJOR_VERSION_UPSTREAM}" != "${CLANDRO_LLVM_MAJOR_VERSION}" ]]; then
		echo "WARN: Version mismatch! Termux clang may not work with wasi-libc sysroot!" 1>&2
	fi
}

clandro_step_configure() {
	# always remove this marker because this package is built in clandro_step_host_build()
	# this prevents "ERROR: No files in package." when the package is built again without deleting
	# the docker container.
	rm -rf $CLANDRO_HOSTBUILD_MARKER
	# also, clandro_step_configure() does not do anything else for this package
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	:
}
