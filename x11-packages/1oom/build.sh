CLANDRO_PKG_HOMEPAGE=https://github.com/1oom-fork/1oom
CLANDRO_PKG_DESCRIPTION="A Master of Orion (1993) game engine recreation"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.11.8"
CLANDRO_PKG_SRCURL=https://github.com/1oom-fork/1oom/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ea55bd0ef2fa9f1dc94629409a2841f5658cc4af99567c49716553f229b8c6fc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='v\d+\.\d+(\.\d+)?'
CLANDRO_PKG_DEPENDS="libandroid-shmem, libsamplerate, libx11, libxext, readline"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-uiclassic
--disable-hwsdl1
--disable-hwsdl1audio
--disable-hwsdl1gl
--disable-hwsdl2
--disable-hwsdl2audio
--disable-hwalleg4
"

clandro_step_pre_configure() {
	autoreconf -fi
	LIBS='-landroid-shmem'
}
