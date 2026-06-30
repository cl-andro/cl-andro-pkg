CLANDRO_PKG_HOMEPAGE=https://www.alsa-project.org
CLANDRO_PKG_DESCRIPTION="The Advanced Linux Sound Architecture (ALSA) - library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.15.3"
CLANDRO_PKG_SRCURL="https://github.com/alsa-project/alsa-lib/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=7a3bee640f1c29fdfa3d1f922185929b546f012c27a73bbb6b424d12488c3c8e
CLANDRO_PKG_DEPENDS="libandroid-sysv-semaphore, libandroid-shmem"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-versioned=no
--with-tmpdir=$CLANDRO_PREFIX/tmp
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
