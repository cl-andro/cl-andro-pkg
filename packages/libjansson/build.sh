CLANDRO_PKG_HOMEPAGE=http://www.digip.org/jansson/
CLANDRO_PKG_DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.15.0"
CLANDRO_PKG_SRCURL=https://github.com/akheron/jansson/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=73ac12bbc62ff536e40c7a3e15ed007993c5ca4d23897de23f1906f891b5a4bb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libjansson-dev"
CLANDRO_PKG_REPLACES="libjansson-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local e=$(sed -n '/^libjansson_la_LDFLAGS/,/^[^\t]/p' src/Makefile.am | \
			sed -En 's/\s*-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p')
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}
