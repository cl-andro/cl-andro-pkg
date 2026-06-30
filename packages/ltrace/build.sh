CLANDRO_PKG_HOMEPAGE=http://www.ltrace.org/
CLANDRO_PKG_DESCRIPTION="Tracks runtime library calls in dynamically linked programs"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.8.1"
CLANDRO_PKG_SRCURL=https://github.com/dkogan/ltrace/archive/82c66409c7a93ca6ad2e4563ef030dfb7e6df4d4.tar.gz
CLANDRO_PKG_SHA256=4aecf69e4a33331aed1e50ce4907e73a98cbccc4835febc3473863474304d547
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++, libelf, libdw"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-werror
--without-libunwind
ac_cv_host=$CLANDRO_ARCH-generic-linux-gnu
"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" == "arm" ]; then
		CFLAGS+=" -DSHT_ARM_ATTRIBUTES=0x70000000+3"
	fi

	./autogen.sh
}
