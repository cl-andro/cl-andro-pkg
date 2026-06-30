CLANDRO_PKG_HOMEPAGE=https://strace.io/
CLANDRO_PKG_DESCRIPTION="Debugging utility to monitor system calls and signals received"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later, GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, LGPL-2.1-or-later, bundled/linux/COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.0"
CLANDRO_PKG_SRCURL=https://github.com/strace/strace/releases/download/v$CLANDRO_PKG_VERSION/strace-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=6c92419be3f2ec560b31728a4652217c59864c8642ba7b1b3771b1b013ad074b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libdw"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-libdw
"

clandro_step_pre_configure() {
	case "$CLANDRO_ARCH" in
		"x86_64") # mpers support seems to break the build on x86_64
		# This is likely an issue in `src/mpers.sh` but I can't track it down.
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" st_cv_m32_mpers=no"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mpers=no"
		;;
	esac
	autoreconf # for configure.ac in configure-find-armv7-cc.patch
	CPPFLAGS+=" -Dfputs_unlocked=fputs"
}
