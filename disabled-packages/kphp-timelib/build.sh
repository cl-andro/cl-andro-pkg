CLANDRO_PKG_HOMEPAGE=https://github.com/derickr/timelib
CLANDRO_PKG_DESCRIPTION="timelib 2020.02 library fork for KPHP"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.rst"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=59ee82faa8d9ed42b1b9b9339e0b989cc929cd4a
CLANDRO_PKG_VERSION=2021.03.01
CLANDRO_PKG_SRCURL=git+https://github.com/VKCOM/timelib
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}
