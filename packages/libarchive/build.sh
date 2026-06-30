CLANDRO_PKG_HOMEPAGE=https://www.libarchive.org/
CLANDRO_PKG_DESCRIPTION="Multi-format archive and compression library"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.7"
CLANDRO_PKG_SRCURL=https://github.com/libarchive/libarchive/releases/download/v$CLANDRO_PKG_VERSION/libarchive-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4b787cca6697a95c7725e45293c973c208cbdc71ae2279f30ef09f52472b9166
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbz2, libiconv, liblzma, libxml2, openssl, zlib"
CLANDRO_PKG_BREAKS="libarchive-dev"
CLANDRO_PKG_REPLACES="libarchive-dev"

# --without-nettle to use openssl instead:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-nettle
--without-lz4
--without-zstd
--disable-acl
--disable-xattr
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=13

	local v=$(sed -En 's/^ARCHIVE_INTERFACE=`echo \$\(\(([0-9]+).*/\1/p' \
			configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_post_make_install() {
	# https://github.com/libarchive/libarchive/issues/1766
	sed -i '/^Requires\.private:/s/ iconv//' \
		$CLANDRO_PREFIX/lib/pkgconfig/libarchive.pc
}
