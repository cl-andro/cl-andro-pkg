CLANDRO_PKG_HOMEPAGE=https://fmt.dev/latest/index.html
CLANDRO_PKG_DESCRIPTION="Open-source formatting library for C++"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:11.2.0
CLANDRO_PKG_SRCURL=https://github.com/fmtlib/fmt/archive/refs/tags/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=bc23066d87ab3168f27cef3e97d545fa63314f5c79df5ea444d41d56f962c6af
# Avoid silently breaking build of revdeps:
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DFMT_TEST=OFF -DBUILD_SHARED_LIBS=TRUE"
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SONAME is changed.
	local _EXPECTED_SOVERSION=11
	local _FMT_VERSION=$(grep '#define FMT_VERSION' "$CLANDRO_PKG_SRCDIR"/include/fmt/base.h  | cut -d ' ' -f 3)
	# The fmt library version in the form major * 10000 + minor * 100 + patch:
	local _ACTUAL_SOVERSION=$(( _FMT_VERSION / 10000 ))
	if [ "$_EXPECTED_SOVERSION" != "$_ACTUAL_SOVERSION" ]; then
		clandro_error_exit "SONAME changed: expected=$_EXPECTED_SOVERSION, actual=$_ACTUAL_SOVERSION"
	fi
}
