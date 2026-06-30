CLANDRO_PKG_HOMEPAGE=https://www.lysator.liu.se/~nisse/nettle/
CLANDRO_PKG_DESCRIPTION="Cryptographic library that is designed to fit easily in more or less any context"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0+really3.10.2"
CLANDRO_PKG_SRCURL="https://mirrors.kernel.org/gnu/nettle/nettle-${CLANDRO_PKG_VERSION#*really}.tar.gz"
CLANDRO_PKG_SHA256=fe9ff51cb1f2abb5e65a6b8c10a92da0ab5ab6eaf26e7fc2b675c45f1fb519b5
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libgmp"
CLANDRO_PKG_BREAKS="libnettle-dev"
CLANDRO_PKG_REPLACES="libnettle-dev"

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES=(
		'lib/libhogweed.so.6'
		'lib/libnettle.so.8'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}
