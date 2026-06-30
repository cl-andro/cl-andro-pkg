CLANDRO_PKG_HOMEPAGE=https://gitlab.com/berdyansk/astra-sm
CLANDRO_PKG_DESCRIPTION="Software for digital TV broadcasting"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=44bcd2852b7f315233267f639730e0e21b9b6c22
CLANDRO_PKG_VERSION=2019.06.19
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/OpenVisionE2/astra-sm
CLANDRO_PKG_SHA256=635bcda7c024adee99c540bcae10cba16946c54108817ac2f3a6f36305b29e85
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_GIT_BRANCH=staging
CLANDRO_PKG_DEPENDS="libdvbcsa, liblua53"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-lua-includes=$CLANDRO_PREFIX/include/lua5.3
--with-lua-libs=$CLANDRO_PREFIX/lib/liblua5.3.so
--with-lua-compiler=no
--with-ffmpeg=no
--with-libcrypto=no
"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}
