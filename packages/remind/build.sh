CLANDRO_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/remind/
CLANDRO_PKG_DESCRIPTION="Sophisticated calendar and alarm program"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:06.02.05"
CLANDRO_PKG_SRCURL=https://dianne.skoll.ca/projects/remind/download/remind-${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=8124d0a057aebfaba30eb63a8c331b3c5e60dd15d24d8e6492316d1536e36305
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_RM_AFTER_INSTALL="bin/tkremind share/man/man1/tkremind.1 bin/cm2rem.tcl share/man/man1/cm2rem.1"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
