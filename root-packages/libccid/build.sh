CLANDRO_PKG_HOMEPAGE=https://ccid.apdu.fr/
CLANDRO_PKG_DESCRIPTION="A generic USB CCID (Chip/Smart Card Interface Devices) driver and ICCD (Integrated Circuit(s) Card Devices)."
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.1"
CLANDRO_PKG_SRCURL=https://github.com/LudovicRousseau/CCID/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5ec0f68d5c3f723229b76540e5b9e23513f45964eacdd09abce5823e449d94f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libusb, pcscd"
CLANDRO_PKG_BUILD_DEPENDS="libpcsclite, flex"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dudev-rules=false
"
