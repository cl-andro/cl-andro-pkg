CLANDRO_PKG_HOMEPAGE=https://github.com/pipeseroni/pipes.sh
CLANDRO_PKG_DESCRIPTION="Animated pipes terminal screensaver"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=581792d4e0ea51e15889ba14a85db1bc9727b83d
CLANDRO_PKG_VERSION=2018.04.22
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/pipeseroni/pipes.sh
CLANDRO_PKG_SHA256=d28a4f49acf31fd5a2d18684d6b6f7a8fca735d98919149e32ce65598091a9b6
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="bash, ncurses-utils"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

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

clandro_step_make_install() {
	cd "$CLANDRO_PKG_SRCDIR"
	make install PREFIX=$CLANDRO_PREFIX
}
