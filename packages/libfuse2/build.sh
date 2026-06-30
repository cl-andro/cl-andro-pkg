# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/libfuse/libfuse
CLANDRO_PKG_DESCRIPTION="FUSE (Filesystem in Userspace) is an interface for userspace programs to export a filesystem to the Linux kernel"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION=2.9.9
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/libfuse/libfuse/archive/refs/tags/fuse-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e57a24721177c3b3dd71cb9239ca46b4dee283db9388d48f7ccd256184982194
#that package is a snapshot, it does not need to be updated.
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libiconv"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-example
--disable-mtab
"

CLANDRO_PKG_RM_AFTER_INSTALL="
etc/init.d
etc/udev
"

clandro_step_pre_configure() {
	export MOUNT_FUSE_PATH=$CLANDRO_PREFIX/bin
	export UDEV_RULES_PATH=$CLANDRO_PREFIX/etc/udev/rules.d
	export INIT_D_PATH=$CLANDRO_PREFIX/etc/init.d
	./makeconf.sh
}
