CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libgtop
CLANDRO_PKG_DESCRIPTION="Library for collecting system monitoring data"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.41.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/libgtop/-/archive/${CLANDRO_PKG_VERSION}/libgtop-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2136f5586377706c267b61c04c3f59ada69d59d83fc8967f137813a8503d0fa7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="glib, libandroid-shmem, libxau"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gtk-doc-html=no
--enable-introspection=yes
--without-examples
"

clandro_step_post_get_source() {
	sed -i "s|/proc/stat|${CLANDRO_PREFIX}/var/libgtop/stat|g" $(grep -rl "/proc/stat")
	rm sysdeps/linux/sem_limits.c
	cp sysdeps/{stub,linux}/sem_limits.c
}

clandro_step_pre_configure() {
	clandro_setup_gir
	NOCONFIGURE=1 ./autogen.sh
	LDFLAGS+=" -landroid-shmem"
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/var/libgtop
	cp -a $CLANDRO_PKG_BUILDER_DIR/procstat $CLANDRO_PREFIX/var/libgtop/stat
}
