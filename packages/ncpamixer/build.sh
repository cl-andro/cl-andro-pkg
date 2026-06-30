CLANDRO_PKG_HOMEPAGE=https://github.com/fulhax/ncpamixer
CLANDRO_PKG_DESCRIPTION="An ncurses mixer for PulseAudio"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.11"
CLANDRO_PKG_SRCURL=https://github.com/fulhax/ncpamixer/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dcc4a0ce20e9fff3f1ff710697971369aed28b6ed2f6c67c42039670eaf0f717
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, ncurses-ui-libs, pulseaudio"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-wordexp"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_WIDE=ON"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/src"
}
