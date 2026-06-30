CLANDRO_PKG_HOMEPAGE=https://www.bunkus.org/videotools/mkvtoolnix/
CLANDRO_PKG_DESCRIPTION="Set of tools to create, edit and inspect Matroska files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="98.0"
CLANDRO_PKG_SRCURL=git+https://codeberg.org/mbunkus/mkvtoolnix
CLANDRO_PKG_GIT_BRANCH="release-$CLANDRO_PKG_VERSION"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
CLANDRO_PKG_DEPENDS="boost, libc++, libebml, libflac, libgmp, libiconv, libmatroska, libogg, libvorbis, qt6-qtbase, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, qt6-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fmt=no
enable_gui=no
--disable-static
--with-boost-filesystem=boost_filesystem
--with-boost-date-time=boost_date_time
--with-qmake6=${CLANDRO_PREFIX}/lib/qt6/bin/host-qmake6
"

clandro_step_pre_configure() {
	export PKG_CONFIG_LIBDIR="$CLANDRO_PKG_CONFIG_LIBDIR"
	./autogen.sh

	# make sure that when this file no longer exists, this block is removed.
	# (context: the Ubuntu 24.04 builder image has autoconf-archive 20220903-3,
	# and this conflicts with the use of 'autoreconf -fi'
	# in packages which are being built against boost 1.89)
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		local file=/usr/share/aclocal/ax_boost_system.m4
		if [[ ! -f "$file" ]]; then
			clandro_error_exit "$file no longer exists. Please edit $CLANDRO_PKG_NAME's build.sh to remove this block."
		fi
		# remove this line too after the above check fails
		# (it willl no longer be necessary when the above check fails):
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ax_cv_boost_system=yes --without-boost-system"
	fi
}

clandro_step_make() {
	rake
}

clandro_step_make_install() {
	rake install
}
