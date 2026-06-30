CLANDRO_PKG_HOMEPAGE=https://github.com/tome2/tome2
CLANDRO_PKG_DESCRIPTION="An open world roguelike adventure set in middle earth"
CLANDRO_PKG_LICENSE="non-free"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=885799917d42ea9e6eb69fc320fa03922cd8cbb4
CLANDRO_PKG_VERSION="2025.12.13"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/tome2/tome2
CLANDRO_PKG_SHA256=a7115bfd526b6b1172cba3b59ba37f975a7f7749d0cb3a40e890988558af7a89
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="boost, libc++, libx11, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DSYSTEM_INSTALL=YES"

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

clandro_step_install_license() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/LICENSE \
		$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/LICENSE
}
