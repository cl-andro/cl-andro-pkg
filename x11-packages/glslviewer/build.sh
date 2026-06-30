CLANDRO_PKG_HOMEPAGE="https://patriciogonzalezvivo.com/2015/glslViewer/"
CLANDRO_PKG_DESCRIPTION="Console-based GLSL Sandbox for 2D/3D shaders"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.2"
CLANDRO_PKG_SRCURL=git+https://github.com/patriciogonzalezvivo/glslViewer
CLANDRO_PKG_GIT_BRANCH="$CLANDRO_PKG_VERSION"
CLANDRO_PKG_DEPENDS="ffmpeg, glfw, glu, libdrm, liblo, libxcb, mesa-dev, ncurses"
CLANDRO_PKG_RECOMMENDS="xorg-server-xvfb"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -Wno-implicit-function-declaration"
}
