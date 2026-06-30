CLANDRO_PKG_HOMEPAGE=https://www.libraw.org/
CLANDRO_PKG_DESCRIPTION="Library for reading RAW files from digital cameras"
CLANDRO_PKG_LICENSE="CDDL-1.0, LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT, LICENSE.CDDL, LICENSE.LGPL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.22.1"
CLANDRO_PKG_SRCURL=https://www.libraw.org/data/LibRaw-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a789dc4e2409e2901d93793a4e0b80c7b49d0d97cf6ad71c850eb7616acfd786
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libjasper, libjpeg-turbo, littlecms, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-openmp
"

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
