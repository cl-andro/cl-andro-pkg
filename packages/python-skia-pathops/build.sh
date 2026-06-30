CLANDRO_PKG_HOMEPAGE=https://github.com/fonttools/skia-pathops
CLANDRO_PKG_DESCRIPTION="Python bindings for the Skia library's Path Ops"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Nguyen Khanh @nguynkhn"
CLANDRO_PKG_VERSION="0.9.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/fonttools/skia-pathops/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4f696a24c83e5bf93b809cbe2a01e55810ec3b05bd88b54a0fdbdc16e2d40eaa
CLANDRO_PKG_DEPENDS="libc++, python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="setuptools, wheel, setuptools_scm, 'Cython>=3.2.0'"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

_SKIA_REPO_URL=git+https://github.com/fonttools/skia.git
_SKIA_REPO_BRANCH=chrome/m143-no-deps
_SKIA_REPO_COMMIT=a777ad7f829750a44b8fa9f6df4a2d1154abf1ad
_SKIA_REPO_DIR=${CLANDRO_PKG_SRCDIR}/src/cpp/skia-builder/skia

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ndk=\"${NDK}\"
is_official_build=true
is_debug=false
skia_enable_pdf=false
skia_enable_discrete_gpu=false
skia_enable_ganesh=false
skia_enable_skottie=false
skia_enable_skshaper=false
skia_use_dng_sdk=false
skia_use_expat=false
skia_use_freetype=false
skia_use_fontconfig=false
skia_use_fonthost_mac=false
skia_use_gl=false
skia_use_harfbuzz=false
skia_use_icu=false
skia_use_libjpeg_turbo_encode=false
skia_use_libjpeg_turbo_decode=false
skia_use_libpng_encode=false
skia_use_libpng_decode=false
skia_use_libwebp_encode=false
skia_use_libwebp_decode=false
skia_use_piex=false
skia_use_xps=false
skia_use_zlib=false
skia_enable_spirv_validation=false
skia_use_lua=false
skia_use_wuffs=false
skia_enable_fontmgr_empty=true
extra_cflags=[\"-DSK_DISABLE_LEGACY_PNG_WRITEBUFFER\", \"-I${CLANDRO_PREFIX}/include\"]
"

clandro_step_pre_configure() {
	clandro_setup_gn

	local _arch
	case "$CLANDRO_ARCH" in
		'aarch64') _arch='arm64';;
		'arm')     _arch='arm';;
		'x86_64')  _arch='x64';;
		'i686')    _arch='x86';;
		*) clandro_error_exit "Architecture not supported by build system"
	esac
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="target_cpu=\"${_arch}\""

	sed -i "s|@SKIA_DIR@|${CLANDRO_PKG_SRCDIR}/skia|g" "${CLANDRO_PKG_SRCDIR}/setup.py"

	export SETUPTOOLS_SCM_PRETEND_VERSION="${CLANDRO_PKG_VERSION}"
	export BUILD_SKIA_FROM_SOURCE=0
	export SKIA_LIBRARY_DIR=$_SKIA_REPO_DIR/out
	LDFLAGS+=" -llog"
	CXXFLAGS+=" -I${CLANDRO_PREFIX}/include/python${CLANDRO_PYTHON_VERSION}/"
}

clandro_step_make() {
	git clone --branch $_SKIA_REPO_BRANCH ${_SKIA_REPO_URL#git+} $_SKIA_REPO_DIR
	cd $_SKIA_REPO_DIR
	git checkout $_SKIA_REPO_COMMIT

	sed -i 's|rebase_path("//bin/gn")|"gn"|g' BUILD.gn
	gn gen out "--args=${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}"
	ninja -C out
}
