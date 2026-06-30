CLANDRO_PKG_HOMEPAGE=https://www.alsa-project.org
CLANDRO_PKG_DESCRIPTION="The Advanced Linux Sound Architecture (ALSA) - plugins"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.12"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/alsa-project/alsa-plugins/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=55fccb55e6e195d73e93924b327f66d371001175c5bff70fdfd90bc026d496ba
CLANDRO_PKG_DEPENDS="libandroid-sysv-semaphore, libandroid-shmem, alsa-lib, pulseaudio"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-versioned=no
--with-tmpdir=$CLANDRO_PREFIX/tmp
--disable-oss
--disable-arcamav
"

clandro_step_pre_configure() {
	# pcm interface uses sysv semaphore which is broken on Android 14+ (issue #20514)
	# Nonetheless, it is still enabled because:
	# 1. probably never called because Android has no /dev/snd/pcm* device
	# 2. still required for other packages in compile time, e.g. pipewire-alsa
	# -landroid-shmem is for depending packages in compile time
	LDFLAGS+=" -landroid-sysv-semaphore -landroid-shmem"
	autoreconf -fi
}

clandro_step_post_make_install() {
	cp ${CLANDRO_PKG_BUILDER_DIR}/99-pulseaudio-default.conf ${CLANDRO_PREFIX}/etc/alsa/conf.d/99-pulseaudio-default.conf
}
