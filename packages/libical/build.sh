CLANDRO_PKG_HOMEPAGE=https://libical.github.io/libical/
CLANDRO_PKG_DESCRIPTION="Libical is an Open Source implementation of the iCalendar protocols and protocol data units"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.20"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/libical/libical/releases/download/v$CLANDRO_PKG_VERSION/libical-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e73de92f5a6ce84c1b00306446b290a2b08cdf0a80988eca0a2c9d5c3510b4c2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libicu"
CLANDRO_PKG_BREAKS="libical-dev"
CLANDRO_PKG_REPLACES="libical-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS=" -DSHARED_ONLY=true -DICAL_GLIB=false -DUSE_BUILTIN_TZDATA=true -DPERL_EXECUTABLE=/usr/bin/perl"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^set\(LIBICAL_LIB_MAJOR_VERSION\s+"?([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
