# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/axboe/fio
CLANDRO_PKG_DESCRIPTION="Flexible I/O Tester"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.42"
CLANDRO_PKG_SRCURL=https://github.com/axboe/fio/archive/refs/tags/fio-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=56b03497a918d07692257890fd759bf73168ad79df5be78a2bcbbdc8ce67895b
CLANDRO_PKG_DEPENDS="openssl, libandroid-shmem, libaio"
CLANDRO_PKG_SUGGESTS="python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"

clandro_step_pre_configure() {
	sed -i "s/@VERSION@/${CLANDRO_PKG_VERSION}/g" $CLANDRO_PKG_SRCDIR/Makefile
}
