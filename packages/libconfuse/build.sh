CLANDRO_PKG_HOMEPAGE=https://github.com/martinh/libconfuse
CLANDRO_PKG_DESCRIPTION="Small configuration file parser library for C"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/martinh/libconfuse/releases/download/v$CLANDRO_PKG_VERSION/confuse-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3a59ded20bc652eaa8e6261ab46f7e483bc13dad79263c15af42ecbb329707b8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libconfuse-dev"
CLANDRO_PKG_REPLACES="libconfuse-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local e=$(sed -En 's/^libconfuse_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			src/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
