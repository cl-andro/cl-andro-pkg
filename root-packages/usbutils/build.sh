CLANDRO_PKG_HOMEPAGE=http://www.linux-usb.org/
CLANDRO_PKG_DESCRIPTION="Collection of USB tools to query connected USB devices"
CLANDRO_PKG_LICENSE="CC0-1.0, GPL-2.0-only, GPL-2.0-or-later, GPL-3.0-only, LGPL-2.1-or-later, MIT"
CLANDRO_PKG_LICENSE_FILE="
LICENSES/CC0-1.0.txt
LICENSES/GPL-2.0-only.txt
LICENSES/GPL-2.0-or-later.txt
LICENSES/GPL-3.0-only.txt
LICENSES/LGPL-2.1-or-later.txt
LICENSES/MIT.txt
"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="019"
CLANDRO_PKG_SRCURL="https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=659f40c440e31ba865c52c818a33d3ba6a97349e3353f8b1985179cb2aa71ec5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="hwdata, libiconv, libusb"

clandro_step_pre_configure() {
	LDFLAGS+=" -liconv"
}

clandro_step_post_make_install() {
	install -vDm 755 "$CLANDRO_PKG_BUILDDIR/usbreset" -t "$CLANDRO_PREFIX/bin"
}
