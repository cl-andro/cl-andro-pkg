CLANDRO_PKG_HOMEPAGE=https://github.com/benhoyt/inih
CLANDRO_PKG_DESCRIPTION="A simple .INI file parser written in C"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="62"
CLANDRO_PKG_SRCURL=https://github.com/benhoyt/inih/archive/refs/tags/r${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9c15fa751bb8093d042dae1b9f125eb45198c32c6704cd5481ccde460d4f8151
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+"
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -n "/library('inih'/,/)\s*$/p" meson.build | \
			sed -En "s/\s*soversion\s*:\s*'?([0-9]+).*/\1/p")
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
