CLANDRO_PKG_HOMEPAGE=https://github.com/rakshasa/rtorrent/wiki
CLANDRO_PKG_DESCRIPTION="Libtorrent BitTorrent library"
CLANDRO_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION="0.16.11"
CLANDRO_PKG_SRCURL=https://github.com/rakshasa/libtorrent/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b1ccbc0f2241d840957d6e82cf1ea35fd537220d3f5478fef23994bd292bf184
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, libcurl, openssl, resolv-conf, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-aligned=true
--without-fastcgi
"

clandro_step_pre_configure() {
	autoreconf -fi

	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
