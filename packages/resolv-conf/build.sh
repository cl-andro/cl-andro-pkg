CLANDRO_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man5/resolv.conf.5.html
CLANDRO_PKG_DESCRIPTION="Resolver configuration file"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true

CLANDRO_PKG_CONFFILES="
etc/hosts
etc/resolv.conf
"

clandro_step_make_install() {
	printf "127.0.0.1 localhost\n::1 ip6-localhost\n" > $CLANDRO_PREFIX/etc/hosts
	printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > $CLANDRO_PREFIX/etc/resolv.conf
}
