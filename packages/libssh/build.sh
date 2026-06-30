CLANDRO_PKG_HOMEPAGE=https://www.libssh.org/
CLANDRO_PKG_DESCRIPTION="Tiny C SSH library"
CLANDRO_PKG_LICENSE="LGPL-2.1, BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="BSD, COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.libssh.org/files/${CLANDRO_PKG_VERSION%.*}/libssh-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=1a6af424d8327e5eedef4e5fe7f5b924226dd617ac9f3de80f217d82a36a7121
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, zlib"
CLANDRO_PKG_BREAKS="libssh-dev"
CLANDRO_PKG_REPLACES="libssh-dev"
# -DWITH_EXAMPLES=OFF prevents:
# src/examples/ssh_server.c:260:9: error: call to undeclared function 'set_default_keys'
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DHAVE_ARGP_H=OFF
-DWITH_GSSAPI=OFF
-DWITH_EXAMPLES=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local _ver=$(sed -En 's/^set\(LIBRARY_SOVERSION "([0-9]+)".*/\1/p' "$CLANDRO_PKG_SRCDIR"/CMakeLists.txt)

	if [[ ! "${_ver}" ]] || [[ "${_ver}" != "${_SOVERSION}" ]]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -D_GNU_SOURCE"
}
