CLANDRO_PKG_HOMEPAGE="https://github.com/Canop/mazter"
CLANDRO_PKG_DESCRIPTION="Mazes in your terminal"
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=a02de683f93a61690d1a4f3b845f654f5e026484
CLANDRO_PKG_VERSION=2022.08.13
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="git+https://github.com/Canop/mazter"
CLANDRO_PKG_SHA256=1196209325408a2335d989e056893c02cea48fcf0da8eacac264679b5f7304cb
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=main
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
	clandro_setup_rust
}
