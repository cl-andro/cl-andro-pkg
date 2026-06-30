# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://www.smartmontools.org/
CLANDRO_PKG_DESCRIPTION="Utility programs (smartctl and smartd) to control and monitor storage systems"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/sourceforge/smartmontools/smartmontools-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=690b83ca331378da9ea0d9d61008c4b22dde391387b9bbad7f29387f2595f76e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libc++, libcap-ng"
CLANDRO_PKG_CONFFILES="etc/smartd.conf"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-scriptpath=$CLANDRO_PREFIX/bin"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
