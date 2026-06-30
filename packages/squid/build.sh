CLANDRO_PKG_HOMEPAGE=http://www.squid-cache.org
CLANDRO_PKG_DESCRIPTION="Full-featured Web proxy cache server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.5"
CLANDRO_PKG_SRCURL=https://github.com/squid-cache/squid/archive/refs/tags/SQUID_${CLANDRO_PKG_VERSION//./_}.tar.gz
CLANDRO_PKG_SHA256=42f7aaf1bb7233161764bba9c3fdb746752657090d7930e129168edb26e1a863
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+(_\d+)+'
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, libcrypt, libexpat, libgnutls, libltdl, libnettle, libxml2, openldap, resolv-conf"

#disk-io uses XSI message queue which are not available on Android.
# Option 'cache_dir' will be unusable.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memrchr=yes
ac_cv_func_strtoll=yes
ac_cv_search_shm_open=
ac_cv_lib_sasl2_sasl_errstring=no
ac_cv_dbopen_libdb=no
squid_cv_gnu_atomics=yes
--datarootdir=$CLANDRO_PREFIX/share/squid
--libexecdir=$CLANDRO_PREFIX/libexec/squid
--mandir=$CLANDRO_PREFIX/share/man
--sysconfdir=$CLANDRO_PREFIX/etc/squid
--with-logdir=$CLANDRO_PREFIX/var/log/squid
--with-pidfile=$CLANDRO_PREFIX/var/run/squid.pid
--disable-external-acl-helpers
--disable-strict-error-checking
--enable-auth
--enable-auth-basic
--enable-auth-digest
--enable-auth-negotiate
--enable-auth-ntlm
--enable-delay-pools
--enable-linux-netfilter
--enable-removal-policies="lru,heap"
--enable-snmp
--disable-disk-io
--disable-storeio
--enable-translation
--with-dl
--without-openssl
--disable-ssl-crtd
--with-size-optimizations
--with-gnutls
--with-libnettle
--without-mit-krb5
--with-maxfd=256
"

clandro_step_pre_configure() {
	# needed for building cf_gen
	export BUILDCXX=g++
	# else it picks up our cross CXXFLAGS
	export BUILDCXXFLAGS=' '
	autoreconf -fi
}

clandro_step_post_massage() {
	# Ensure that necessary directories exist, otherwise squid fill fail.
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/cache/squid"
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/log/squid"
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/run"
}
