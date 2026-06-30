CLANDRO_PKG_HOMEPAGE=https://nghttp2.org/
CLANDRO_PKG_DESCRIPTION="nghttp HTTP 2.0 library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.69.0"
CLANDRO_PKG_SRCURL=https://github.com/nghttp2/nghttp2/releases/download/v${CLANDRO_PKG_VERSION}/nghttp2-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1fb324b6ec2c56f6bde0658f4139ffd8209fa9e77ce98fd7a5f63af8d0e508ad
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libnghttp2-dev"
CLANDRO_PKG_REPLACES="libnghttp2-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"
# The tools are not built due to --enable-lib-only:
CLANDRO_PKG_RM_AFTER_INSTALL="share/man/man1 share/nghttp2/fetch-ocsp-response"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=14

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
