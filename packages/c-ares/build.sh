CLANDRO_PKG_HOMEPAGE=https://c-ares.org/
CLANDRO_PKG_DESCRIPTION="Library for asynchronous DNS requests (including name resolves)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.34.6"
CLANDRO_PKG_SRCURL=https://github.com/c-ares/c-ares/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4358939ff800b13b92f37d5fdda003718101faedfbdee792d6b79ddc1a53d890
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BREAKS="c-ares-dev"
CLANDRO_PKG_REPLACES="c-ares-dev"
# Build with cmake to install cmake/c-ares/*.cmake files:
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_RM_AFTER_INSTALL="bin/"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local e=$(sed -En 's/^\s*SET\s*\(CARES_LIB_VERSIONINFO\s+"?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			CMakeLists.txt)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
