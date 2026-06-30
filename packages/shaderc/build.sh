CLANDRO_PKG_HOMEPAGE=https://github.com/google/shaderc
CLANDRO_PKG_DESCRIPTION="Collection of tools, libraries, and tests for Vulkan shader compilation"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2026.2"
CLANDRO_PKG_SRCURL=https://github.com/google/shaderc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f924178e75e3293082481b25ed64d5e48a795b479dac3bd3c83d23070855df42
CLANDRO_PKG_DEPENDS="glslang, spirv-tools, libc++"
CLANDRO_PKG_BUILD_DEPENDS="spirv-headers"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DSHADERC_SKIP_TESTS=ON
-Dglslang_SOURCE_DIR=$CLANDRO_PREFIX/include/glslang
"

clandro_step_pre_configure() {
	# based on Arch Linux:
	# https://gitlab.archlinux.org/archlinux/packaging/packages/shaderc/-/blob/3ed2bcb6358e964d75044f075a04cb0cd8bd4fa8/README.md
	# de-vendor libs and disable git versioning
	local _SPIRV_TOOLS_BUILD_SH="$CLANDRO_SCRIPTDIR/packages/spirv-tools/build.sh"
	local _GLSLANG_BUILD_SH="$CLANDRO_SCRIPTDIR/packages/glslang/build.sh"
	local _SPIRV_TOOLS_VERSION=$(bash -c ". $_SPIRV_TOOLS_BUILD_SH; echo \${CLANDRO_PKG_VERSION#*:}")
	local _GLSLANG_VERSION=$(bash -c ". $_GLSLANG_BUILD_SH; echo \${CLANDRO_PKG_VERSION#*:}")

	sed '/examples/d;/third_party/d' -i "$CLANDRO_PKG_SRCDIR/CMakeLists.txt"
	sed '/build-version/d' -i "$CLANDRO_PKG_SRCDIR/glslc/CMakeLists.txt"
	cat <<- EOF > "$CLANDRO_PKG_SRCDIR/glslc/src/build-version.inc"
		"${CLANDRO_PKG_VERSION}\\n"
		"${_SPIRV_TOOLS_VERSION}\\n"
		"${_GLSLANG_VERSION}\\n"
	EOF
}
