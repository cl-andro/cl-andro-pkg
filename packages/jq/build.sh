CLANDRO_PKG_HOMEPAGE=https://jqlang.org/
CLANDRO_PKG_DESCRIPTION="Command-line JSON processor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/jqlang/jq/releases/download/jq-$CLANDRO_PKG_VERSION/jq-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2be64e7129cecb11d5906290eba10af694fb9e3e7f9fc208a311dc33ca837eb0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+(\.\d+)?"
CLANDRO_PKG_DEPENDS="oniguruma"
CLANDRO_PKG_BREAKS="jq-dev"
CLANDRO_PKG_REPLACES="jq-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-oniguruma"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local e=$(sed -En 's/^libjq_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
