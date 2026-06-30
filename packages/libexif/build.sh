CLANDRO_PKG_HOMEPAGE=https://libexif.github.io/
CLANDRO_PKG_DESCRIPTION="Library for reading and writing EXIF image metadata"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.26"
CLANDRO_PKG_SRCURL=https://github.com/libexif/libexif/archive/refs/tags/libexif-0_6_22-release.tar.gz
CLANDRO_PKG_SHA256=46498934b7b931526fdee8fd8eb77a1dddedd529d5a6dbce88daf4384baecc54
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_BREAKS="libexif-dev"
CLANDRO_PKG_REPLACES="libexif-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=12

	local a
	for a in LIBEXIF_CURRENT LIBEXIF_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LIBEXIF_CURRENT - _LIBEXIF_AGE ))
	if [ ! "${_LIBEXIF_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}
