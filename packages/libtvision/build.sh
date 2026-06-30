CLANDRO_PKG_HOMEPAGE=https://github.com/magiblot/tvision
CLANDRO_PKG_DESCRIPTION="A modern port of Turbo Vision 2.0 with Unicode support"
CLANDRO_PKG_LICENSE="Public Domain, MIT"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=423aeb568a181ffebb3695859654385950588a93
CLANDRO_PKG_VERSION=2025.10.31
CLANDRO_PKG_SRCURL=git+https://github.com/magiblot/tvision
CLANDRO_PKG_SHA256=f812a2f18597e7610ac0f819104b4c7a72c15fdf2cad77f4b3d9e6853c562e05
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DTV_BUILD_EXAMPLES=OFF
-DTV_BUILD_USING_GPM=OFF
-DTV_OPTIMIZE_BUILD=OFF
"

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
