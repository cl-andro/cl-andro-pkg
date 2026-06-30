CLANDRO_PKG_HOMEPAGE=https://strophe.im/libstrophe
CLANDRO_PKG_DESCRIPTION="libstrophe is a minimal XMPP library written in C"
CLANDRO_PKG_LICENSE="MIT, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/strophe/libstrophe/releases/download/${CLANDRO_PKG_VERSION}/libstrophe-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d079668474d5c3aa4555347c33e77014a1071629603557cc506a6bc6f82e01f5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, libexpat, c-ares"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-cares"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -En 's/^m4_define\(\[v_maj\],\s*\[([0-9]+)\].*/\1/p' \
				configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	./bootstrap.sh
}
