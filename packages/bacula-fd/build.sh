CLANDRO_PKG_HOMEPAGE=https://www.bacula.org
CLANDRO_PKG_DESCRIPTION="Bacula backup software"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="15.0.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/bacula/files/bacula/${CLANDRO_PKG_VERSION}/bacula-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=294afd3d2eb9d5b71c3d0e88fdf19eb513bfdb843b28d35c0552e4ae062827a1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, liblzo, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES=etc/bacula/bacula-fd.conf
CLANDRO_PKG_SERVICE_SCRIPT=("bacula-fd" "${CLANDRO_PREFIX}/bin/bacula-fd")
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=${CLANDRO_PREFIX}/etc/bacula
--with-plugindir=${CLANDRO_PREFIX}/lib/bacula
--mandir=${CLANDRO_PREFIX}/share/man
--with-logdir=${CLANDRO_PREFIX}/var/log
--with-working-dir=${CLANDRO_PREFIX}/var/run/bacula
--with-pid-dir=${CLANDRO_PREFIX}/var/run/bacula
--with-scriptdir=${CLANDRO_PREFIX}/etc/bacula/scripts
--with-lzo=${CLANDRO_PREFIX}
--with-ssl
--enable-smartalloc
--enable-conio
--enable-client-only
--with-baseport=9102
ac_cv_func_setpgrp_void=yes
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	LDFLAGS+=" -Wl,-rpath=${CLANDRO_PREFIX}/lib/bacula -Wl,--enable-new-dtags"
}

clandro_step_post_massage() {
	mkdir -p ${CLANDRO_PKG_MASSAGEDIR}${CLANDRO_PREFIX}/var/run/bacula
}
