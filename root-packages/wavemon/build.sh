CLANDRO_PKG_HOMEPAGE=https://github.com/uoaerg/wavemon
CLANDRO_PKG_DESCRIPTION="Ncurses-based monitoring application for wireless network devices"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.7"
CLANDRO_PKG_SRCURL=https://github.com/uoaerg/wavemon/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=768d7c580fcc592efcacac924dcfd2ebe131608f5c8ac67d36e35731e1ac683a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcap, libnl, libnl-cli, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_pthread_pthread_create=yes"

clandro_step_pre_configure() {
	CPPFLAGS+=" -I$CLANDRO_PREFIX/include/libnl3"
}
