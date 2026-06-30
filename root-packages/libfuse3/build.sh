CLANDRO_PKG_HOMEPAGE=https://github.com/libfuse/libfuse
CLANDRO_PKG_DESCRIPTION="FUSE (Filesystem in Userspace) is an interface for userspace programs to export a filesystem to the Linux kernel"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION=3.16.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libfuse/libfuse/archive/refs/tags/fuse-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1bc306be1a1f4f6c8965fbdd79c9ccca021fdc4b277d501483a711cbd7dbcd6c

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddisable-mtab=true
-Dexamples=false
-Dtests=false
-Dsbindir=bin
-Dmandir=share/man
-Dudevrulesdir=$CLANDRO_PREFIX/etc/udev/rules.d
-Duseroot=false
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__off64_t=off64_t"
}
