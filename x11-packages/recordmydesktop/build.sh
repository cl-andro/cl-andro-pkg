CLANDRO_PKG_HOMEPAGE=https://github.com/Enselic/recordmydesktop
CLANDRO_PKG_DESCRIPTION="Produces a OGG encapsulated Theora/Vorbis recording of your desktop"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/Enselic/recordmydesktop/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=69602d32c1be82cd92083152c7c44c0206ca0d6419d76a6144ffcfe07b157a72
CLANDRO_PKG_DEPENDS="libandroid-shmem, libice, libogg, libpopt, libsm, libtheora, libvorbis, libx11, libxdamage, libxext, libxfixes, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pthread_pthread_mutex_lock=yes
--enable-oss=no
--enable-jack=no
"

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+="/recordmydesktop"
}

clandro_step_pre_configure() {
	autoreconf -fi

	export LIBS="-landroid-shmem"
}
