CLANDRO_PKG_HOMEPAGE=https://github.com/brailcom/speechd
CLANDRO_PKG_DESCRIPTION="Common interface to speech synthesis"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SHA256=32a730f6fb5981b9bec7e04f3674fd7d29e54935f46cf6354dbb9ab1f9b23b2d
CLANDRO_PKG_SRCURL=https://github.com/brailcom/speechd/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_DEPENDS="dotconf, espeak, glib, libiconv, libltdl, libsndfile, pulseaudio, python, speechd-data, libandroid-posix-semaphore"
CLANDRO_PKG_BUILD_DEPENDS="libiconv-static, libsndfile-static"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SETUP_PYTHON=true

# Fails to find generated headers
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-pulse
--with-espeak-ng
"

# spd-conf needs python stuff, so remove for now
CLANDRO_PKG_RM_AFTER_INSTALL="bin/spd-conf"

# We cannot run cross-compiled programs to get help message, so disable
# man-page generation with help2man
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="ac_cv_prog_HELP2MAN="

clandro_step_pre_configure() {
	export am_cv_python_pythondir="${CLANDRO_PREFIX}/lib/python${CLANDRO_PYTHON_VERSION}/site-packages"
	export am_cv_python_pyexecdir="$am_cv_python_pythondir"
	LDFLAGS+=" -landroid-posix-semaphore"
	./build.sh
}

clandro_step_post_massage() {
	find lib -name '*.la' -delete
}
