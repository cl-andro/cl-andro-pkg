# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/martijnvanbrummelen/nwipe
CLANDRO_PKG_DESCRIPTION="A program that will securely erase the entire contents of disks"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.40"
CLANDRO_PKG_SRCURL=https://github.com/martijnvanbrummelen/nwipe/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=826ff4431324cc06f34da7a86829cd5c1a1bb10cf5528bbe7d07676816b813f8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses, ncurses-ui-libs, parted, libconfig, hdparm"
CLANDRO_PKG_SUGGESTS="smartmontools"

clandro_step_pre_configure() {
	autoreconf -fi
}
