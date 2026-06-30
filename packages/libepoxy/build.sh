CLANDRO_PKG_HOMEPAGE=https://github.com/anholt/libepoxy
CLANDRO_PKG_DESCRIPTION="Library handling OpenGL function pointer management"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5.10
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/anholt/libepoxy/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a7ced37f4102b745ac86d6a70a9da399cc139ff168ba6b8002b4d8d43c900c15
CLANDRO_PKG_DEPENDS="opengl"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dglx=yes
-Degl=yes
-Dx11=true
-Dtests=false
"
