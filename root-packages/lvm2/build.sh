CLANDRO_PKG_HOMEPAGE=https://sourceware.org/lvm2/
CLANDRO_PKG_DESCRIPTION="A device-mapper library from LVM2 package"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1, BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.BSD, COPYING.LIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.03.40"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/sourceware/lvm2/releases/LVM2.${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=60c9bb5c0a109f20267bb40ba50c00c84a110fc14c129f21afb5566929bf5645
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libaio, libandroid-support, libblkid, readline"
CLANDRO_PKG_BREAKS="libdevmapper-dev"
CLANDRO_PKG_REPLACES="libdevmapper-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-pkgconfig
--disable-selinux
--with-default-system-dir=$CLANDRO_PREFIX/etc/lvm
--with-default-pid-dir=$CLANDRO_PREFIX/var/run
--with-default-profile-subdir=profile.d
--with-default-run-dir=$CLANDRO_PREFIX/var/run
--with-default-locking-dir=$CLANDRO_PREFIX/var/run/lock/lvm
--with-confdir=$CLANDRO_PREFIX/etc
--with-symvers=no
"

clandro_step_pre_configure() {
	export CFLAGS="$CFLAGS $CPPFLAGS"
	export CLDFLAGS="$LDFLAGS"

	find "$CLANDRO_PKG_SRCDIR" -name '*.[ch]' | xargs -n 1 \
		sed -i 's/\([^A-Za-z0-9_]\)\(stack[^A-Za-z0-9_]\)/\1log_\2/g'
}
