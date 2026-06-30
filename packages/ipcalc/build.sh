CLANDRO_PKG_HOMEPAGE=http://jodies.de/ipcalc
CLANDRO_PKG_DESCRIPTION="Calculates IP broadcast, network, Cisco wildcard mask, and host ranges"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_VERSION=0.51
CLANDRO_PKG_SRCURL=https://github.com/kjokjo/ipcalc/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a4dbfaeb7511b81830793ab9936bae9d7b1b561ad33e29106faaaf97ba1c117e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	cp $CLANDRO_PKG_SRCDIR/ipcalc $CLANDRO_PREFIX/bin/
}
