CLANDRO_PKG_HOMEPAGE=https://github.com/rockdaboot/libpsl
CLANDRO_PKG_DESCRIPTION="Public Suffix List library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.21.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/rockdaboot/libpsl/releases/download/${CLANDRO_PKG_VERSION}/libpsl-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1dcc9ceae8b128f3c0b3f654decd0e1e891afc6ff81098f227ef260449dae208
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libidn2, libunistring"
CLANDRO_PKG_BREAKS="libpsl-dev"
CLANDRO_PKG_REPLACES="libpsl-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			libtool_version_info.txt)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fiv
}
