CLANDRO_PKG_HOMEPAGE=https://github.com/ericchiang/xpup
CLANDRO_PKG_DESCRIPTION="pup for XML"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=3c408621ad9b5693323acd7d1b455f78444e0c5f
CLANDRO_PKG_VERSION=2021.12.26
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/ericchiang/xpup
CLANDRO_PKG_SHA256=080e5bba8556f488dfecfbfcc39b1c8e476cb1a2128f09d3f29f0aa7e7f52278
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_BUILD_IN_SRC=true

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

clandro_step_make() {
	clandro_setup_golang

	go mod init
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 xpup $CLANDRO_PREFIX/bin/
}
