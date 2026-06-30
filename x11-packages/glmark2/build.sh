CLANDRO_PKG_HOMEPAGE=https://github.com/glmark2/glmark2
CLANDRO_PKG_DESCRIPTION="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2023.01
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/glmark2/glmark2/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8fece3fc323b643644a525be163dc4931a4189971eda1de8ad4c1712c5db3d67
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libjpeg-turbo, libx11, opengl, libpng, libjpeg-turbo"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dflavors=x11-gl,x11-glesv2,x11-gl-egl
"
