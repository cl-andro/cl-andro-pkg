CLANDRO_PKG_HOMEPAGE=https://www.cryptopp.com/
CLANDRO_PKG_DESCRIPTION="A free C++ class library of cryptographic schemes"
CLANDRO_PKG_LICENSE="BSL-1.0, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="License.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.9.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_${CLANDRO_PKG_VERSION//./_}.tar.gz
CLANDRO_PKG_SHA256=ab5174b9b5c6236588e15a1aa1aaecb6658cdbe09501c7981ac8db276a24d9ab
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="libcpufeatures"
CLANDRO_PKG_BREAKS="cryptopp-dev"
CLANDRO_PKG_REPLACES="cryptopp-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_MAKE_INSTALL_TARGET="install-lib"

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/
share/cryptopp/
"

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libcryptopp.so.8"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}

clandro_step_pre_configure() {
	export CXXFLAGS+=" -fPIC -I$CLANDRO_PREFIX/include/ndk_compat -fPIC"
	export CLANDRO_PKG_EXTRA_MAKE_ARGS+=" all static dynamic libcryptopp.pc CC=$CC CXX=$CXX"
	export CFLAGS+=" -I$CLANDRO_PREFIX/include/ndk_compat"
	export LDFLAGS+=" -l:libndk_compat.a"
}
