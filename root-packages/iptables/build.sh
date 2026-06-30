CLANDRO_PKG_HOMEPAGE=https://www.netfilter.org/projects/iptables
CLANDRO_PKG_DESCRIPTION="Program used to configure the Linux 2.4 and later kernel packet filtering ruleset"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.13"
CLANDRO_PKG_SRCURL=https://www.netfilter.org/projects/iptables/files/iptables-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1afcd33da9e8f913ace6a2126788162e207e26f5d5e29c6573c0e581ffc58b99
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libmnl, libnftnl, libandroid-spawn"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-xt-lock-name=$CLANDRO_PREFIX/var/run/xtables.lock
"

clandro_step_pre_configure() {
	export CFLAGS+=" -Dindex=strchr -Drindex=strrchr -D__STDC_FORMAT_MACROS=1"
}
