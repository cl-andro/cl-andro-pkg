CLANDRO_PKG_HOMEPAGE=http://www.mega-nerd.com/libsndfile
CLANDRO_PKG_DESCRIPTION="Library for reading/writing audio files"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/libsndfile/libsndfile/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ffe12ef8add3eaca876f04087734e6e8e029350082f3251f565fa9da55b52121
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libflac, libmp3lame, libogg, libopus, libvorbis"
CLANDRO_PKG_BREAKS="libsndfile-dev"
CLANDRO_PKG_REPLACES="libsndfile-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-sqlite
--disable-alsa
"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/ share/man/man1/"

clandro_step_post_get_source() {
	rm -f CMakeLists.txt

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^m4_define\(\['"${a,,}"'\],\s*\[([0-9]+)\].*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}
