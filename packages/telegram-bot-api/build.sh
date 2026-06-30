CLANDRO_PKG_HOMEPAGE=https://github.com/tdlib/telegram-bot-api
CLANDRO_PKG_DESCRIPTION="Telegram Bot API server"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@Sarisan"
CLANDRO_PKG_SRCURL=git+https://github.com/tdlib/telegram-bot-api
_COMMIT=6d1b62b51bdc543c10f854aae751e160e5b7b9c5
_COMMIT_DATE=2024.10.31
CLANDRO_PKG_VERSION=${_COMMIT_DATE//./}
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SHA256=cf210ec318fbc40bf5febd74d942e0624997dc9a4dc1ff2dd78f76e693adf3e6
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="libc++, openssl, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_get_source() {
	rm -rf $CLANDRO_PKG_SRCDIR
	mkdir -p $CLANDRO_PKG_SRCDIR
	cd $CLANDRO_PKG_SRCDIR
	git clone --depth 1 --branch ${CLANDRO_PKG_GIT_BRANCH} \
		${CLANDRO_PKG_SRCURL#git+} .
	git fetch --unshallow
	git checkout $_COMMIT
	git submodule update --init --recursive --depth=1
}

clandro_step_post_get_source() {
	local version="$(git log -1 --format=%cs | sed 's/-//g')"
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

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja
	cmake "-DCMAKE_BUILD_TYPE=Release" $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS "$CLANDRO_PKG_SRCDIR" -G Ninja
	cmake --build . --target prepare_cross_compiling
}
