CLANDRO_PKG_HOMEPAGE=https://xiph.org/ogg/
CLANDRO_PKG_DESCRIPTION="Library for working with the Ogg multimedia container format"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/xiph/ogg/releases/download/v${CLANDRO_PKG_VERSION}/libogg-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=5c8253428e181840cd20d41f3ca16557a9cc04bad4a3d04cce84808677fa1061
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libogg-dev"
CLANDRO_PKG_REPLACES="libogg-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in LIB_CURRENT LIB_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LIB_CURRENT - _LIB_AGE ))
	if [ ! "${_LIB_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
