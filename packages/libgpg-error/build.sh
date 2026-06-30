CLANDRO_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libgpg-error/
CLANDRO_PKG_DESCRIPTION="Small library that defines common error values for all GnuPG components"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.58"
CLANDRO_PKG_SRCURL="https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=f943aea9a830a8bd938e5124b579efaece24a3225ff4c3d27611a80ce1260c27
CLANDRO_PKG_BREAKS="libgpg-error-dev"
CLANDRO_PKG_REPLACES="libgpg-error-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="share/common-lisp"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-install-gpg-error-config
"

clandro_step_post_get_source() {
	# Upstream only has Android definitions for platform-specific lock objects.
	# See https://lists.gnupg.org/pipermail/gnupg-devel/2014-January/028203.html
	# for how to generate a lock-obj header file on devices.

	# For aarch64 this was generated on a device:
	cp $CLANDRO_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h $CLANDRO_PKG_SRCDIR/src/syscfg/

	if [ $CLANDRO_ARCH = i686 ]; then
		# Android i686 has same config as arm (verified by generating a file on a i686 device):
		cp $CLANDRO_PKG_SRCDIR/src/syscfg/lock-obj-pub.arm-unknown-linux-androideabi.h \
			$CLANDRO_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	elif [ $CLANDRO_ARCH = x86_64 ]; then
		# FIXME: Generate on device.
		cp $CLANDRO_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h \
			$CLANDRO_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
	# USE_POSIX_THREADS_WEAK is being enabled for on-device build and causes
	# errors, so force-disable it.
	sed -i 's/USE_POSIX_THREADS_WEAK/DONT_USE_POSIX_THREADS_WEAK/g' configure
}
