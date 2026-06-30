CLANDRO_PKG_HOMEPAGE=https://upscaledb.com/
CLANDRO_PKG_DESCRIPTION="A database engine written in C/C++"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=cb124e1f91601872a7b3bd4da10e5fa97a8da86b
_COMMIT_DATE=2021.08.20
CLANDRO_PKG_VERSION=2.2.1p${_COMMIT_DATE//./}
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL=git+https://github.com/cruppstahl/upscaledb
CLANDRO_PKG_SHA256=83e26f9f099897f347129470b494487bddf96c3d09ab4747251135d47d8b4256
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="boost, libc++, libsnappy, openssl, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-simd
--disable-java
--disable-remote
--with-boost=$CLANDRO_PREFIX
--without-tcmalloc
--without-berkeleydb
"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	sh bootstrap.sh

	CPPFLAGS+=" -DBOOST_TIMER_ENABLE_DEPRECATED"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
