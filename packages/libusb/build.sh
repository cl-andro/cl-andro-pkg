CLANDRO_PKG_HOMEPAGE=https://libusb.info/
CLANDRO_PKG_DESCRIPTION="A C library that provides generic access to USB devices"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.29"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libusb/libusb/releases/download/v${CLANDRO_PKG_VERSION}/libusb-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=5977fc950f8d1395ccea9bd48c06b3f808fd3c2c961b44b0c2e6e29fc3a70a85
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libusb-dev"
CLANDRO_PKG_REPLACES="libusb-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-udev"

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libusb-1.0.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
