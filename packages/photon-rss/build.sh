CLANDRO_PKG_HOMEPAGE=https://git.sr.ht/~ghost08/photon
CLANDRO_PKG_DESCRIPTION="An RSS/Atom reader with the focus on speed, usability and a bit of unix philosophy"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=d11f8834457a7b7e3cd73c64fe349454c59f38ef
CLANDRO_PKG_VERSION=2023.02.02
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://git.sr.ht/~ghost08/photon
CLANDRO_PKG_SHA256=dd1d81bbcdad45e35d7d8a842bfb6bb0502985bbc57af0748281a71e2cf74a6f
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"

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
