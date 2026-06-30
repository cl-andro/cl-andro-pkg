CLANDRO_PKG_HOMEPAGE=https://libgit2.github.com/
CLANDRO_PKG_DESCRIPTION="C library implementing Git core methods"
# License: GPL-2.0 with linking exception
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.3"
CLANDRO_PKG_SRCURL=https://github.com/libgit2/libgit2/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d532172d7ab24d2a25944e2434212d63ee85f3650e97b5f7579e7f201a78ad64
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libssh2, openssl, pcre2, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libiconv"
CLANDRO_PKG_BREAKS="libgit2-dev"
CLANDRO_PKG_REPLACES="libgit2-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DUSE_SSH=ON
-DREGEX_BACKEND=pcre2
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1.9

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1-2)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
