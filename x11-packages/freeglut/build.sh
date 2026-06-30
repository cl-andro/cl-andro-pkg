CLANDRO_PKG_HOMEPAGE=https://freeglut.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Provides functionality for small OpenGL programs"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/freeglut/freeglut-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9c3d4d6516fbfa0280edc93c77698fb7303e443c1aaaf37d269e3288a6c3ea52
CLANDRO_PKG_DEPENDS="glu, libx11, libxi, libxrandr, opengl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_TERMUX=OFF
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_get_source() {
	sed -i CMakeLists.txt \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_TERMUX/g'
}
