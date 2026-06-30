CLANDRO_PKG_HOMEPAGE=https://lnav.org/
CLANDRO_PKG_DESCRIPTION="An advanced log file viewer for the small-scale"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.0"
CLANDRO_PKG_SRCURL=https://github.com/tstack/lnav/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bf142441fc85e99c256ebe661e4199768acbd340da1344554da49a9e867a49ea
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-glob, libandroid-spawn, libandroid-utimes, libarchive, libbz2, libc++, libcurl, libsqlite, libunistring, pcre2, readline, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-system-paths
--disable-static
--with-pcre2=$CLANDRO_PREFIX
ac_cv_path_CARGO_CMD=
"

clandro_step_pre_configure() {
	# for bundled notcurses repository
	(
		cd src/third-party/notcurses
		patch -p1 -i "$CLANDRO_PKG_BUILDER_DIR"/../notcurses/include-notcurses-ncport.h.patch
		patch -p1 -i "$CLANDRO_PKG_BUILDER_DIR"/../notcurses/src-lib-termdesc.h.patch
	)

	autoreconf -fi

	CXXFLAGS+=" -DC4_LINUX -Wno-c++11-narrowing"
	LDFLAGS+=" -landroid-glob -landroid-spawn -landroid-utimes"
}
