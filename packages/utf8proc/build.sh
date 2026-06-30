CLANDRO_PKG_HOMEPAGE=https://github.com/JuliaLang/utf8proc
CLANDRO_PKG_DESCRIPTION="Library for processing UTF-8 Unicode data"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.3"
CLANDRO_PKG_SRCURL=https://github.com/JuliaLang/utf8proc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=abfed50b6d4da51345713661370290f4f4747263ee73dc90356299dfc7990c78
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="utf8proc-dev"
CLANDRO_PKG_REPLACES="utf8proc-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^MAJOR=([0-9]+).*/\1/p' Makefile)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	rm $CLANDRO_PKG_SRCDIR/CMakeLists.txt
}
