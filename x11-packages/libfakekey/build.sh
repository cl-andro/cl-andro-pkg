CLANDRO_PKG_HOMEPAGE=https://www.yoctoproject.org/tools-resources/projects/matchbox
CLANDRO_PKG_DESCRIPTION="X virtual keyboard library."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.3
CLANDRO_PKG_REVISION=22
CLANDRO_PKG_SRCURL=https://git.yoctoproject.org/cgit/cgit.cgi/libfakekey/snapshot/libfakekey-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d282fa6481a5b85f71e36e8bad4cfa938cc8eaac4c42ffa27f9203ac634813f4
CLANDRO_PKG_DEPENDS="libx11, libxtst"
CLANDRO_PKG_EXTRA_MAKE_ARGS="AM_LDFLAGS=-lX11"

clandro_step_pre_configure() {
	autoreconf -i
}
