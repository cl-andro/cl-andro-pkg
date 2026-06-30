CLANDRO_PKG_HOMEPAGE=https://github.com/libhangul/libhangul
CLANDRO_PKG_DESCRIPTION="A library to support hangul input method logic"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libhangul/libhangul/releases/download/libhangul-${CLANDRO_PKG_VERSION}/libhangul-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ea04e6a0cf4840a2a3b5641c1761068c78691036db839d0838f4e7a6553a5120
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libexpat, libiconv"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local a
	for a in LIBHANGUL_CURRENT LIBHANGUL_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LIBHANGUL_CURRENT - _LIBHANGUL_AGE ))
	if [ ! "${_LIBHANGUL_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	# prefer autotools
	rm CMakeLists.txt

	LDFLAGS+=" -landroid-glob"
}
