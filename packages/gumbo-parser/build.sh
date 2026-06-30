CLANDRO_PKG_HOMEPAGE=https://github.com/google/gumbo-parser
CLANDRO_PKG_DESCRIPTION="An HTML5 parsing library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.10.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/google/gumbo-parser/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=28463053d44a5dfbc4b77bcf49c8cee119338ffa636cc17fc3378421d714efad
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local e=$(sed -En 's/^libgumbo_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	./autogen.sh
}
