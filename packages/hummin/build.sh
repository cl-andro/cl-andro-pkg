CLANDRO_PKG_HOMEPAGE=https://trantor.is/
CLANDRO_PKG_DESCRIPTION="Command line client for the imperial library of trantor"
CLANDRO_PKG_LICENSE="WTFPL"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=b117aef9c64348b1ef262a99316f1e51328efe18
CLANDRO_PKG_VERSION=2021.05.18
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://gitlab.com/trantor/hummin
CLANDRO_PKG_SHA256=a59bdd3b08cf50786fe08d94edd1d35223f14e63bf4850a99ce394753b5405d3
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

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin hummin
}
