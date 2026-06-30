CLANDRO_PKG_HOMEPAGE=https://apr.apache.org/
CLANDRO_PKG_DESCRIPTION="Apache Portable Runtime Library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.6"
CLANDRO_PKG_REVISION=2
# old tarballs are removed in https://dlcdn.apache.org/apr/apr-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SRCURL=https://archive.apache.org/dist/apr/apr-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=49030d92d2575da735791b496dc322f3ce5cff9494779ba8cc28c7f46c5deb32
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libuuid"
# libcrypt build-dependency is needed to build apache2.
CLANDRO_PKG_BUILD_DEPENDS="libcrypt"
CLANDRO_PKG_BREAKS="apr-dev"
CLANDRO_PKG_REPLACES="apr-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--includedir=$CLANDRO_PREFIX/include/apr-1
--with-installbuilddir=$CLANDRO_PREFIX/share/apr-1/build
ac_cv_func_getrandom=no
ac_cv_have_decl_SYS_getrandom=no
ap_cv_atomic_builtins=yes
apr_cv_mutex_recursive=yes
apr_cv_epoll=yes
apr_cv_epoll_create1=yes
apr_cv_dup3=yes
apr_cv_accept4=yes
apr_cv_sock_cloexec=yes
ac_cv_file__dev_zero=yes
ac_cv_strerror_r_rc_int=yes
ac_cv_func_setpgrp_void=yes
ac_cv_struct_rlimit=yes
ac_cv_func_sem_open=no
apr_cv_process_shared_works=yes
apr_cv_mutex_robust_shared=no
ac_cv_o_nonblock_inherited=no
apr_cv_tcp_nodelay_with_cork=yes
apr_cv_gai_addrconfig=yes
ac_cv_sizeof_pid_t=4
ac_cv_sizeof_ssize_t=$(( CLANDRO_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_size_t=$(( CLANDRO_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_off_t=$(( CLANDRO_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_struct_iovec=$(( CLANDRO_ARCH_BITS==32 ? 8 : 16 ))
"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/apr.exp"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(sed -En 's/#define APR_MAJOR_VERSION.*([0-9]+).*/\1/p' include/apr_version.h)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
