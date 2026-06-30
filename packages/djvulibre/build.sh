CLANDRO_PKG_HOMEPAGE=https://djvu.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Suite to create, manipulate and view DjVu ('déjà vu') documents"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.30"
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/djvu/djvulibre-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ee5e457d4cfebe566f94b99e5e3d3cc7f5c79ddb741c2ac2ba2e456f00329644
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libjpeg-turbo, libtiff"

clandro_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh

	# ERROR: ./lib/libdjvulibre.so contains undefined symbols: __aeabi_idiv
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
