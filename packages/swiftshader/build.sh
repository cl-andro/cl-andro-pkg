CLANDRO_PKG_HOMEPAGE=https://swiftshader.googlesource.com/SwiftShader
CLANDRO_PKG_DESCRIPTION="A high-performance CPU-based implementation of the Vulkan graphics API"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT_DATE=2025.06.25
_COMMIT_HASH=436722b391188ad8c1d1d5dd2447c38ac7f71439
CLANDRO_PKG_VERSION=$_COMMIT_DATE
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/google/swiftshader/archive/$_COMMIT_HASH.tar.gz
CLANDRO_PKG_SHA256=971423bdf3e5890234bc9d9f82e7d6e648b2533f8e2dfe4265c3209b831dfd06
CLANDRO_PKG_DEPENDS="libandroid-shmem, libc++, vulkan-loader-generic"
CLANDRO_PKG_BUILD_DEPENDS="vulkan-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DSWIFTSHADER_BUILD_TESTS=FALSE
-DSWIFTSHADER_WARNINGS_AS_ERRORS=FALSE
-DSPIRV_HEADERS_SKIP_INSTALL=ON
-DSKIP_SPIRV_TOOLS_INSTALL=OFF
"

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"
	LDFLAGS+=" -Wl,-undefined-version"
}

clandro_step_make_install() {
	cp libvk_swiftshader.so $CLANDRO_PREFIX/lib

	mkdir -p $CLANDRO_PREFIX/share/vulkan/icd.d/
	python $CLANDRO_PKG_SRCDIR/src/Vulkan/write_icd_json.py \
		--input $CLANDRO_PKG_SRCDIR/src/Vulkan/vk_swiftshader_icd.json.tmpl \
		--output $CLANDRO_PREFIX/share/vulkan/icd.d/vk_swiftshader_icd.json \
		--library_path $CLANDRO_PREFIX/lib/libvk_swiftshader.so
}
