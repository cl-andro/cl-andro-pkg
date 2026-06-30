CLANDRO_PKG_HOMEPAGE=https://phantomjs.org/
CLANDRO_PKG_DESCRIPTION="A headless WebKit scriptable with JavaScript"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE.BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=0a0b0facb16acfbabb7804822ecaf4f4b9dce3d2
CLANDRO_PKG_VERSION=2020.07.13
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/ariya/phantomjs
CLANDRO_PKG_SHA256=5603bfc300c6bf712db3d8e7dea6b0f8d97eb470b8ab589e9cec3b290ed56d57
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtwebkit"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_FORCE_CMAKE=true

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
