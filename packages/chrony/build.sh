CLANDRO_PKG_HOMEPAGE=https://chrony-project.org/
CLANDRO_PKG_DESCRIPTION="chrony is an implementation of the Network Time Protocol (NTP)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.8"
CLANDRO_PKG_SRCURL=https://chrony-project.org/releases/chrony-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=33ea8eb2a4daeaa506e8fcafd5d6d89027ed6f2f0609645c6f149b560d301706
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libandroid-shmem, libcap, libgnutls, libnettle, libnss, libtomcrypt, readline"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--chronyvardir=${CLANDRO_PREFIX}/var/lib/chrony"

clandro_step_pre_configure() {
	LDFLAGS="${LDFLAGS/-Wl,--as-needed/} -landroid-glob -landroid-shmem"
}
