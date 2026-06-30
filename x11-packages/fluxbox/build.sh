CLANDRO_PKG_HOMEPAGE=http://www.fluxbox.org
CLANDRO_PKG_DESCRIPTION="A lightweight and highly-configurable window manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.7
CLANDRO_PKG_REVISION=38
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/fluxbox/fluxbox-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=fc8c75fe94c54ed5a5dd3fd4a752109f8949d6df67a48e5b11a261403c382ec0
CLANDRO_PKG_DEPENDS="fontconfig, fribidi, imlib2, libc++, libiconv, libx11, libxext, libxft, libxinerama, libxpm, libxrandr, libxrender, xorg-xmessage"
CLANDRO_PKG_RECOMMENDS="aterm, feh"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-imlib2
--enable-xft
--enable-xinerama
"

clandro_step_pre_configure() {
	export CXXFLAGS="${CXXFLAGS} -Wno-c++11-narrowing -std=c++11"
}
