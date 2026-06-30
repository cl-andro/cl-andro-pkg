CLANDRO_PKG_HOMEPAGE=https://github.com/KhronosGroup/glslang
CLANDRO_PKG_DESCRIPTION="OpenGL and OpenGL ES shader front end and validator"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="16.3.0"
CLANDRO_PKG_SRCURL=https://github.com/KhronosGroup/glslang/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=efff5a15258dce1ca2d323bf64c974f5fca03778174615dbc30c8d36db645bf5
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="spirv-tools"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DALLOW_EXTERNAL_SPIRV_TOOLS=ON
"

clandro_step_post_make_install() {
	# build system only build static or shared at a time
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-DBUILD_SHARED_LIBS=ON
	"
	clandro_step_configure
	clandro_step_make
	clandro_step_make_install
}
