CLANDRO_PKG_HOMEPAGE=https://glm.g-truc.net/
CLANDRO_PKG_DESCRIPTION="C++ mathematics library for graphics software based on the GLSL specifications"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="copying.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.1
CLANDRO_PKG_SRCURL=https://github.com/g-truc/glm/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9f3174561fd26904b23f0db5e560971cbf9b3cbda0b280f04d5c379d03bf234c
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DGLM_BUILD_TESTS=OFF"
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/share/doc/glm
	cp -r "$CLANDRO_PKG_SRCDIR"/doc "$CLANDRO_PREFIX"/share/doc/glm
}
