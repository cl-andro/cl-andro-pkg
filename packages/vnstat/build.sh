# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/vergoh/vnstat
CLANDRO_PKG_DESCRIPTION="A console-based network traffic monitor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.13"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/vergoh/vnstat/releases/download/v${CLANDRO_PKG_VERSION}/vnstat-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c9fe19312d1ec3ddfbc4672aa951cf9e61ca98dc14cad3d3565f7d9803a6b187
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libsqlite"
CLANDRO_PKG_SERVICE_SCRIPT=("vnstat" "exec su -c \"PATH=\$PATH $CLANDRO_PREFIX/bin/vnstatd -n 2>&1\"")

# from docker root package: https://github.com/termux/termux-packages/blob/master/root-packages/docker/build.sh
clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/var/service/vnstat/
	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "su -c pkill vnstatd"
	} > $CLANDRO_PREFIX/var/service/vnstat/finish
	chmod u+x $CLANDRO_PREFIX/var/service/vnstat/finish
}
