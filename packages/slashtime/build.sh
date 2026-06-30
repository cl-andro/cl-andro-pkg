CLANDRO_PKG_HOMEPAGE=https://github.com/istathar/slashtime
CLANDRO_PKG_DESCRIPTION="A small program which displays the time in various places"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=aa4e96d36ec6e4cb56e3567c560c1c209f4fd492
CLANDRO_PKG_VERSION=2023.01.04
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/istathar/slashtime
CLANDRO_PKG_SHA256=c15f9df0cee790156460a624cedc4c5b4367aba46b48d729f987e9b4d32a8132
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
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

clandro_step_configure() {
	:
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	install -Dm700 -T slashtime.pl $CLANDRO_PREFIX/bin/slashtime
}
