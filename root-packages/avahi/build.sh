CLANDRO_PKG_HOMEPAGE=https://www.avahi.org/
CLANDRO_PKG_DESCRIPTION="A system for service discovery on a local network via mDNS/DNS-SD"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8
CLANDRO_PKG_REVISION=11
CLANDRO_PKG_SRCURL=https://github.com/lathiat/avahi/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c15e750ef7c6df595fb5f2ce10cac0fee2353649600e6919ad08ae8871e4945f
CLANDRO_PKG_DEPENDS="dbus, glib, libandroid-glob, libdaemon, libevent, libexpat, resolv-conf"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-compat-libdns_sd
--enable-dbus
--enable-introspection=yes
--disable-gdbm
--disable-gtk3
--disable-mono
--disable-pygobject
--disable-python
--disable-python-dbus
--disable-qt5
--with-distro=none
ac_cv_func_chroot=no
"
clandro_step_pre_configure() {
	clandro_setup_gir

	autoreconf -fi
	LDFLAGS+=" -landroid-glob"
}

clandro_step_post_make_install() {
	ln -sf avahi-compat-libdns_sd/dns_sd.h $CLANDRO_PREFIX/include/dns_sd.h
}
