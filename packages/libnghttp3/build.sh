CLANDRO_PKG_HOMEPAGE=https://nghttp2.org/nghttp3/
CLANDRO_PKG_DESCRIPTION="HTTP/3 library written in C"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.15.0"
CLANDRO_PKG_SRCURL=https://github.com/ngtcp2/nghttp3/releases/download/v${CLANDRO_PKG_VERSION}/nghttp3-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6da0cd06b428d32a54c58137838505d9dc0371a900bb8070a46b29e1ceaf2e0f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^AC_SUBST\('"${a}"',\s*([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}
