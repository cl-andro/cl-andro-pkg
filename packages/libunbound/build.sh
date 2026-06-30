CLANDRO_PKG_HOMEPAGE=https://unbound.net/
CLANDRO_PKG_DESCRIPTION="A validating, recursive, caching DNS resolver"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.25.0"
CLANDRO_PKG_SRCURL=https://nlnetlabs.nl/downloads/unbound/unbound-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=062a6eda723fe2f041bee4079b76981569f1d12e066bbd74800242fc1ebddec7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libevent, libnghttp2, libngtcp2, openssl, resolv-conf"
CLANDRO_PKG_BUILD_DEPENDS="python, swig"
CLANDRO_PKG_BREAKS="unbound (<< 1.17.1-1)"
CLANDRO_PKG_REPLACES="unbound (<< 1.17.1-1)"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="swig"

# `pythonmodule` makes core lib/libunbound.so depend on python. Do not enable it.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_chown=no
ac_cv_func_chroot=no
ac_cv_func_getpwnam=no
--enable-event-api
--enable-ipsecmod
--enable-linux-ip-local-port-range
--enable-tfo-server
--with-libevent=$CLANDRO_PREFIX
--with-libexpat=$CLANDRO_PREFIX
--without-libhiredis
--without-libmnl
--with-pyunbound
--without-pythonmodule
--with-libnghttp2=$CLANDRO_PREFIX
--with-libngtcp2=$CLANDRO_PREFIX
--with-ssl=$CLANDRO_PREFIX
--with-pidfile=$CLANDRO_PREFIX/var/run/unbound.pid
--with-username=
"

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/run"
}
