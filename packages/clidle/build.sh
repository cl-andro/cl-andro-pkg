CLANDRO_PKG_HOMEPAGE=https://github.com/ajeetdsouza/clidle
CLANDRO_PKG_DESCRIPTION="Play Wordle over SSH"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=fe27556c1147333af2cfe81cbc40f4f60ea191ee
CLANDRO_PKG_VERSION=2022.05.25
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/ajeetdsouza/clidle
CLANDRO_PKG_SHA256=68bec2f8445fe78d6295811d30adadc1aa16abce9911f65e619da67d75e3fdd5
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_GROUPS="games"
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

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin clidle
}
