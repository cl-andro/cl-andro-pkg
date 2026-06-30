CLANDRO_PKG_HOMEPAGE=https://github.com/royhills/arp-scan
CLANDRO_PKG_DESCRIPTION="arp-scan is a command-line tool for system discovery and fingerprinting. It constructs and sends ARP requests to the specified IP addresses, and displays any responses that are received."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.10.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/royhills/arp-scan/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=204b13487158b8e46bf6dd207757a52621148fdd1d2467ebd104de17493bab25
CLANDRO_PKG_DEPENDS="libpcap"

if [[ ${CLANDRO_ARCH_BITS} == 32 ]]; then
	# Retrieved from compilation on device:
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="pgac_cv_snprintf_long_long_int_format=%lld"
fi

clandro_step_pre_configure () {
	cp ${CLANDRO_PKG_BUILDER_DIR}/hsearch/* ${CLANDRO_PKG_SRCDIR}/
	autoreconf -fi
}
