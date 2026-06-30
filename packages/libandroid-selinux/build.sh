CLANDRO_PKG_HOMEPAGE=https://selinuxproject.org
CLANDRO_PKG_DESCRIPTION="Android fork of libselinux, an SELinux userland library"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=14.0.0.11
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://android.googlesource.com/platform/external/selinux
CLANDRO_PKG_GIT_BRANCH=android-${CLANDRO_PKG_VERSION%.*}_r${CLANDRO_PKG_VERSION##*.}
CLANDRO_PKG_SHA256=SKIP_CHECKSUM
CLANDRO_PKG_DEPENDS="pcre2"
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# FIXME: We would like to enable checksums when downloading
	# tar files, but they change each time as the tar metadata
	# differs: https://github.com/google/gitiles/issues/84
	git clone --depth 1 --single-branch --branch $CLANDRO_PKG_GIT_BRANCH \
		$CLANDRO_PKG_SRCURL .
	cp -f "$CLANDRO_PKG_BUILDER_DIR/Makefile-android" "$CLANDRO_PKG_SRCDIR/libselinux"
	cp -f "$CLANDRO_PKG_BUILDER_DIR/clandro_build.h" "$CLANDRO_PKG_SRCDIR/libselinux/include"
}

clandro_step_make() {
	make -C libselinux -f Makefile-android
}

clandro_step_make_install() {
	make -C libselinux -f Makefile-android install
}
