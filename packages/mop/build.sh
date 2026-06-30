CLANDRO_PKG_HOMEPAGE="https://github.com/mop-tracker/mop"
CLANDRO_PKG_DESCRIPTION="Stock market tracker"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=0e9bd17e0b2899c11bbd3b62db387e81ac61ea30
_COMMIT_DATE=20250317
CLANDRO_PKG_VERSION="2025.03.17"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="git+https://github.com/mop-tracker/mop"
CLANDRO_PKG_SHA256=31815ba873bf27505bfed03bf529d86f844c0f9c269bbb1f1edd64789a5a910a
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

	go build -o mop $CLANDRO_PKG_SRCDIR/cmd/mop
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" mop
}
