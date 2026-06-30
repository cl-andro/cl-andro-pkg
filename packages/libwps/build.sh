CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/libwps/
CLANDRO_PKG_DESCRIPTION="a Microsoft Works file word processor format import filter library"
CLANDRO_PKG_LICENSE="LGPL-2.1, MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.14"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/project/libwps/libwps/libwps-${CLANDRO_PKG_VERSION}/libwps-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=365b968e270e85a8469c6b160aa6af5619a4e6c995dbb04c1ecc1b4dd13e80de
CLANDRO_PKG_DEPENDS="libwpd, librevenge"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"

	autoreconf -fi
}

clandro_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libwps-0.4.so
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
