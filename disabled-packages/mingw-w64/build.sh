CLANDRO_PKG_HOMEPAGE=https://github.com/termux/termux-packages
CLANDRO_PKG_DESCRIPTION="MinGW-w64 toolchain (metapackage)"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_DEPENDS="clang, mingw-w64-crt, mingw-w64-gcc-libs"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	mkdir -p ${CLANDRO_PREFIX}/bin
	local arch
	for arch in x86_64 i686; do
		local target="${arch}-w64-mingw32"
		local sysroot="${CLANDRO_PREFIX}/${target}"
		local clang_opts="--start-no-unused-arguments"
		clang_opts+=" --target=${target}"
		clang_opts+=" --sysroot=${sysroot}"
		clang_opts+=" -fuse-ld=lld"
		clang_opts+=" -rtlib=libgcc"
		local clangxx_opts="${clang_opts} -stdlib=libstdc++"
		clang_opts+=" --end-no-unused-arguments"
		clangxx_opts+=" --end-no-unused-arguments"
		cat > ${CLANDRO_PREFIX}/bin/${target}-clang <<-EOF
			#!${CLANDRO_PREFIX}/bin/sh
			exec clang ${clang_opts} "\$@"
		EOF
		chmod 0700 ${CLANDRO_PREFIX}/bin/${target}-clang
		cat > ${CLANDRO_PREFIX}/bin/${target}-clang++ <<-EOF
			#!${CLANDRO_PREFIX}/bin/sh
			exec clang++ ${clangxx_opts} "\$@"
		EOF
		chmod 0700 ${CLANDRO_PREFIX}/bin/${target}-clang++
	done
}
