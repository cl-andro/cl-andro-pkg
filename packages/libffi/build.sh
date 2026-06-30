CLANDRO_PKG_HOMEPAGE=https://sourceware.org/libffi/
CLANDRO_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libffi/libffi/releases/download/v${CLANDRO_PKG_VERSION}/libffi-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=138607dee268bdecf374adf9144c00e839e38541f75f24a1fcf18b78fda48b2d
CLANDRO_PKG_BREAKS="libffi-dev"
CLANDRO_PKG_REPLACES="libffi-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/libffi-${CLANDRO_PKG_VERSION}/include"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=8

	local e=$(sed -En 's/^[^0-9#]*([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			libtool-version)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_post_configure() {
	# work around since mmap can't be written and marked executable in android anymore from userspace
	echo "#define FFI_MMAP_EXEC_WRIT 1" >> fficonfig.h
}
