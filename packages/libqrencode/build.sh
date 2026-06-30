CLANDRO_PKG_HOMEPAGE=https://fukuchi.org/works/qrencode/
CLANDRO_PKG_DESCRIPTION="Fast and compact library for encoding data in a QR Code symbol"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION=4.1.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/fukuchi/libqrencode/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=5385bc1b8c2f20f3b91d258bf8ccc8cf62023935df2d2676b5b67049f31a049c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libpng, zlib"
CLANDRO_PKG_BREAKS="libqrencode-dev"
CLANDRO_PKG_REPLACES="libqrencode-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
