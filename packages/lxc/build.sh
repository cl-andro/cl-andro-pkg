# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://linuxcontainers.org/
CLANDRO_PKG_DESCRIPTION="Linux Containers"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
# v3.1.0 is the last version confirmed to work.
# Do not update it unless you tested it on your device.
CLANDRO_PKG_VERSION=1:3.1.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://linuxcontainers.org/downloads/lxc/lxc-${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=4d8772c25baeaea2c37a954902b88c05d1454c91c887cb6a0997258cfac3fdc5
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="gnupg, libcap, libseccomp, rsync, wget"
CLANDRO_PKG_BREAKS="lxc-dev"
CLANDRO_PKG_REPLACES="lxc-dev"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-distro=termux
--with-runtime-path=$CLANDRO_PREFIX/var/run
--disable-apparmor
--disable-selinux
--enable-seccomp
--enable-capabilities
--disable-examples
--disable-werror
"

clandro_step_post_make_install() {
	# Simple helper script for mounting cgroups.
	install -Dm755 "$CLANDRO_PKG_BUILDER_DIR"/lxc-setup-cgroups.sh \
		"$CLANDRO_PREFIX"/bin/lxc-setup-cgroups
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" "$CLANDRO_PREFIX"/bin/lxc-setup-cgroups
}
