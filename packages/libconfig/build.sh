CLANDRO_PKG_HOMEPAGE=https://github.com/hyperrealm/libconfig
CLANDRO_PKG_DESCRIPTION="C/C++ Configuration File Library"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.2"
CLANDRO_PKG_SRCURL=https://github.com/hyperrealm/libconfig/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8e71983761b08c65b15b769b3ec1d980036c461fdfd415c7183378a4b3eac8f4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="libconfig-dev"
CLANDRO_PKG_REPLACES="libconfig-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=15

	local e=$(sed -En 's/^VERINFO\s*=\s*-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			lib/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi

	# ld.lld: error: non-exported symbol '__aeabi_d2lz' is referenced by 'libconfig++.so'
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
