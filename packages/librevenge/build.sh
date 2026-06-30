CLANDRO_PKG_HOMEPAGE=https://sf.net/p/libwpd/librevenge/
CLANDRO_PKG_DESCRIPTION="library for REVerses ENGineered formats filters"
CLANDRO_PKG_LICENSE="LGPL-2.1, MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.5"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://sourceforge.net/projects/libwpd/files/librevenge/librevenge-${CLANDRO_PKG_VERSION}/librevenge-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=106d0c44bb6408b1348b9e0465666fa83b816177665a22cd017e886c1aaeeb34
CLANDRO_PKG_DEPENDS="boost, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
"

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}

clandro_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/librevenge-0.0.so
lib/librevenge-generators-0.0.so
lib/librevenge-stream-0.0.so
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
