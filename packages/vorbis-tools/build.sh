CLANDRO_PKG_HOMEPAGE=https://github.com/xiph/vorbis-tools
CLANDRO_PKG_DESCRIPTION="Ogg Vorbis tools"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://downloads.xiph.org/releases/vorbis/vorbis-tools-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a1fe3ddc6777bdcebf6b797e7edfe0437954b24756ffcc8c6b816b63e0460dde
CLANDRO_PKG_AUTO_UPDATE=true
# libflac for flac support in oggenc:
CLANDRO_PKG_DEPENDS="libiconv, libvorbis, libflac, libogg"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ogg123
"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}
