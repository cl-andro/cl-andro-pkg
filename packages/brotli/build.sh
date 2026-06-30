CLANDRO_PKG_HOMEPAGE=https://github.com/google/brotli
CLANDRO_PKG_DESCRIPTION="lossless compression algorithm and format (command line utility)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_SRCURL=https://github.com/google/brotli/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=816c96e8e8f193b40151dad7e8ff37b1221d019dbcb9c35cd3fadbfe6477dfec
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="brotli-dev"
CLANDRO_PKG_REPLACES="brotli-dev"
CLANDRO_PKG_FORCE_CMAKE=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local _ABI_CURRENT="$(grep -E '^#define\s+BROTLI_ABI_CURRENT\s+' \
			c/common/version.h | awk '{ print $3 }')"
	local _ABI_AGE="$(grep -E '^#define\s+BROTLI_ABI_AGE\s+' \
			c/common/version.h | awk '{ print $3 }')"
	local v=$(( _ABI_CURRENT - _ABI_AGE ))
	if [ ! "${_ABI_CURRENT}" ] || [ ! "${_ABI_AGE}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/man/man{1,3}
	cp "$CLANDRO_PKG_SRCDIR/docs/brotli.1" "$CLANDRO_PREFIX/share/man/man1/"
	cp "$CLANDRO_PKG_SRCDIR"/docs/*.3 "$CLANDRO_PREFIX/share/man/man3/"
}
