CLANDRO_PKG_HOMEPAGE=https://ollama.com/
CLANDRO_PKG_DESCRIPTION="Get up and running with large language models"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.23.2"
CLANDRO_PKG_SRCURL=git+https://github.com/ollama/ollama
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="vulkan-headers"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DLLAMA_BUILD_TESTS=OFF
-DGGML_BACKEND_DL=ON
-DGGML_CPU_ALL_VARIANTS=ON
-DGGML_OPENMP=OFF
-DGGML_VULKAN=ON
-DGGML_VULKAN_SHADERS_GEN_TOOLCHAIN=$CLANDRO_PKG_BUILDER_DIR/host-toolchain.cmake
"

clandro_step_pre_configure() {
	export PATH="$NDK/shader-tools/linux-x86_64:$PATH"

	local _libvulkan=vulkan
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "false" && "${CLANDRO_PKG_API_LEVEL}" -lt 28 ]]; then
		_libvulkan="${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot/usr/lib/${CLANDRO_HOST_PLATFORM}/28/libvulkan.so"
	fi
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DVulkan_LIBRARY=${_libvulkan}"
}

clandro_step_make_install() {
	cd $CLANDRO_PKG_SRCDIR
	clandro_setup_golang

	go build -trimpath -ldflags="-w -s -X=github.com/ollama/ollama/version.Version=$CLANDRO_PKG_VERSION -X=github.com/ollama/ollama/server.mode=release"
	install -Dm700 ollama $CLANDRO_PREFIX/bin/

	mkdir -p $CLANDRO_PREFIX/lib/ollama
	cp -fv $CLANDRO_PKG_BUILDDIR/lib/ollama/* $CLANDRO_PREFIX/lib/ollama/
}
