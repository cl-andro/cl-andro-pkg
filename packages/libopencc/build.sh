CLANDRO_PKG_HOMEPAGE=https://github.com/BYVoid/OpenCC
CLANDRO_PKG_DESCRIPTION="An opensource project for conversions between Traditional Chinese, Simplified Chinese and Japanese Kanji (Shinjitai)"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_SRCURL=https://github.com/BYVoid/OpenCC/archive/refs/tags/ver.${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=548e890c9a882df4f121bad7e52751581e94e9a043767549f7e233524a46be75
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++, marisa"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_SYSTEM_MARISA=ON"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_cmake
	cmake $CLANDRO_PKG_SRCDIR
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_post_configure() {
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/src/tools:$PATH
}
