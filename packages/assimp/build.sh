CLANDRO_PKG_HOMEPAGE=https://assimp.sourceforge.net/index.html
CLANDRO_PKG_DESCRIPTION="Library to import various well-known 3D model formats in an uniform manner"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.0.5"
CLANDRO_PKG_SRCURL="https://github.com/assimp/assimp/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=edf3749559c2b7d1f758ffb66fc5bec62186221e623b7f2e8969f17ee46ecb6f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_BREAKS="assimp-dev"
CLANDRO_PKG_REPLACES="assimp-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DASSIMP_BUILD_SAMPLES=OFF"
