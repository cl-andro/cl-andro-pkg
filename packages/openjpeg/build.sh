CLANDRO_PKG_HOMEPAGE=https://www.openjpeg.org/
CLANDRO_PKG_DESCRIPTION="JPEG 2000 image compression library"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.4"
CLANDRO_PKG_SRCURL=https://github.com/uclouvain/openjpeg/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a695fbe19c0165f295a8531b1e4e855cd94d0875d2f88ec4b61080677e27188a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="openjpeg-dev"
CLANDRO_PKG_REPLACES="openjpeg-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_STATIC_LIBS=OFF"
# for fast building packages that depend on openjpeg with cmake

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _MAJOR_VERSION=2
	local _SOVERSION=7

	case "$CLANDRO_PKG_VERSION" in
		${_MAJOR_VERSION}.*|*:${_MAJOR_VERSION}.* ) ;;
		* ) clandro_error_exit "Version guard check failed." ;;
	esac

	local v=$(sed -En 's/^.*set\(OPENJPEG_SOVERSION ([0-9]+).*$/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Force symlinks to be overwritten:
	rm -Rf $CLANDRO_PREFIX/lib/libopenjp2.so*
}
