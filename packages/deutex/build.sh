CLANDRO_PKG_HOMEPAGE=https://github.com/Doom-Utils/deutex/
CLANDRO_PKG_DESCRIPTION="WAD composer for Doom, Heretic, Hexen, and Strife"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.2.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Doom-Utils/deutex/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=74bc442169623d5b35dd5c62d8d1747da4358a6d499a6c8a21e6a71c3cf97e98
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libpng, zlib"

clandro_step_pre_configure() {
	./bootstrap
}
