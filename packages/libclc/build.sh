CLANDRO_PKG_HOMEPAGE=https://libclc.llvm.org/
CLANDRO_PKG_DESCRIPTION="Open source implementation of the library requirements of the OpenCL C programming language"
CLANDRO_PKG_LICENSE="Apache-2.0, NCSA"
CLANDRO_PKG_LICENSE_FILE="libclc/LICENSE.TXT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(
	21.1.3
	21.1.1
)
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(
	https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANDRO_PKG_VERSION[0]}/llvm-project-${CLANDRO_PKG_VERSION[0]}.src.tar.xz
	https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/refs/tags/v${CLANDRO_PKG_VERSION[1]}.tar.gz
)
CLANDRO_PKG_SHA256=(
	9c9db50d8046f668156d83f6b594631b4ca79a0d96e4f19bed9dc019b022e58f
	dda46febdb060a1d5cc2ceeb9682ccaf33e55ae294fd0793274531b54f07c46b
)
CLANDRO_PKG_BUILD_DEPENDS="clang, libc++, libllvm, libllvm-static, lld, llvm, spirv-llvm-translator"
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_FORCE_CMAKE=true

clandro_step_post_get_source() {
	mkdir -p llvm/projects
	ln -fsv ../../SPIRV-LLVM-Translator-${CLANDRO_PKG_VERSION[1]} llvm/projects
}

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake \
		-B llvm \
		-S "${CLANDRO_PKG_SRCDIR}/llvm" \
		-G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_ENABLE_PROJECTS="clang" \
		-DLLVM_INCLUDE_BENCHMARKS=OFF \
		-DLLVM_INCLUDE_EXAMPLES=OFF \
		-DLLVM_INCLUDE_TESTS=OFF \
		-DLLVM_INCLUDE_UTILS=OFF
	ninja \
		-C llvm \
		-j "$CLANDRO_PKG_MAKE_PROCESSES" \
		clang llvm-as llvm-link llvm-spirv opt

	export PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/bin:${PATH}"

	cmake \
		-B libclc \
		-S "${CLANDRO_PKG_SRCDIR}/libclc" \
		-G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_DIR="${CLANDRO_PKG_HOSTBUILD_DIR}/llvm/lib/llvm" \
		-DCMAKE_INSTALL_PREFIX="${CLANDRO_PREFIX}"
	ninja \
		-C libclc \
		-j "$CLANDRO_PKG_MAKE_PROCESSES"
	ninja \
		-C libclc \
		-j "$CLANDRO_PKG_MAKE_PROCESSES" \
		install

	echo "INFO: ${CLANDRO_PREFIX}/share/pkgconfig/libclc.pc"
	cat "${CLANDRO_PREFIX}/share/pkgconfig/libclc.pc"
	echo
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
