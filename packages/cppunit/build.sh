CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/cppunit
CLANDRO_PKG_DESCRIPTION="A C++ unit testing framework"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.15.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://dev-www.libreoffice.org/src/cppunit-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7

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

clandro_step_post_make_install() {
	ln -sfr $PREFIX/lib/libcppunit-1.15.so $PREFIX/lib/libcppunit.so
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libcppunit-1.15.so
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
