CLANDRO_PKG_HOMEPAGE=https://libexpat.github.io/
CLANDRO_PKG_DESCRIPTION="XML parsing C library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.0"
CLANDRO_PKG_SRCURL=https://github.com/libexpat/libexpat/releases/download/R_${CLANDRO_PKG_VERSION//./_}/expat-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=586494499ac3ad46d87f3beda7b1f770c1c8026a9b60e151593f8b29089a52ca
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_BREAKS="libexpat-dev"
CLANDRO_PKG_REPLACES="libexpat-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-xmlwf --without-docbook"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local a
	for a in LIBCURRENT LIBAGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' configure.ac)
	done
	local v=$(( _LIBCURRENT - _LIBAGE ))
	if [ ! "${_LIBCURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	sed -i 's/^\(linux\*android\)\*)/\1-notermux)/' configure
}

clandro_step_post_massage() {
	# Check if SONAME is properly set:
	if ! readelf -d lib/libexpat.so | grep -q '(SONAME).*\[libexpat\.so\.'; then
		clandro_error_exit "SONAME for libexpat.so is not properly set."
	fi
}
