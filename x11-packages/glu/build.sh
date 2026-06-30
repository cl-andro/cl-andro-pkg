CLANDRO_PKG_HOMEPAGE=https://cgit.freedesktop.org/mesa/glu/
CLANDRO_PKG_DESCRIPTION="Mesa OpenGL Utility library"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=9.0.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mesa.freedesktop.org/archive/glu/glu-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=bd43fe12f374b1192eb15fe20e45ff456b9bc26ab57f0eee919f96ca0f8a330f
CLANDRO_PKG_DEPENDS="libc++, opengl"
CLANDRO_PKG_CONFLICTS="libglu"
CLANDRO_PKG_REPLACES="libglu"

clandro_step_post_get_source() {
	cp "${CLANDRO_PKG_BUILDER_DIR}"/LICENSE ./
}

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
