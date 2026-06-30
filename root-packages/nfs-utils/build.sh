CLANDRO_PKG_HOMEPAGE=https://linux-nfs.org/
CLANDRO_PKG_DESCRIPTION="Linux NFS userland utilities"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.9.1"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/nfs/nfs-utils-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=3e9804674f44d18c693f2aedf8c8cc92531edc9f93e6220f70380d3993c500c8
CLANDRO_PKG_DEPENDS="keyutils, libblkid, libcap, libdevmapper, libevent, libmount, libnl, libsqlite, libtirpc, libuuid, openldap"
CLANDRO_PKG_BUILD_DEPENDS="libxml2"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_resolv___res_querydomain=yes
libsqlite3_cv_is_recent=yes
--disable-gss
--disable-sbin-override
--with-modprobedir=$CLANDRO_PREFIX/lib/modprobe.d
--with-mountfile=$CLANDRO_PREFIX/etc/nfsmounts.conf
--with-nfsconfig=$CLANDRO_PREFIX/etc/nfs.conf
--with-start-statd=$CLANDRO_PREFIX/bin/start-statd
--with-statedir=$CLANDRO_PREFIX/var/lib/nfs
"
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/udev
"

clandro_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_GNU"

	local _lib="$CLANDRO_PKG_BUILDDIR/_lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"
	local f
	for f in strverscmp versionsort; do
		$CC $CFLAGS $CPPFLAGS "$CLANDRO_PKG_BUILDER_DIR/${f}.c" \
			-fvisibility=hidden -c -o "./${f}.o"
	done
	$AR cru libversionsort.a strverscmp.o versionsort.o
	echo '!<arch>' > libresolv.a
	popd

	LDFLAGS+=" -L${_lib} -l:libversionsort.a"
}
