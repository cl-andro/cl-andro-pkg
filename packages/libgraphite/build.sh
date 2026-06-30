CLANDRO_PKG_HOMEPAGE=https://github.com/silnrsi/graphite
CLANDRO_PKG_DESCRIPTION="Font system for multiple languages"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.14
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/silnrsi/graphite/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7a3b342c5681921ce2e0c2496509d30b5b078399d5a7bd2358f95166d57d91df
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="libgraphite-dev"
CLANDRO_PKG_REPLACES="libgraphite-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/gr2fonttest"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^set\(GRAPHITE_API_CURRENT\s+([0-9]+).*/\1/p' \
			src/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
