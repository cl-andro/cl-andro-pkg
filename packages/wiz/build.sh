CLANDRO_PKG_HOMEPAGE=http://wiz-lang.org/
CLANDRO_PKG_DESCRIPTION="A high-level assembly language for writing homebrew software for retro console platforms"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=5a8ea1ce15953d6ed9d222a54a31cb6447c79121
CLANDRO_PKG_VERSION=2025.04.10
CLANDRO_PKG_SRCURL=git+https://github.com/wiz-lang/wiz
CLANDRO_PKG_SHA256=fb4feb428aee4b62966f33ad7197503c13b3511f636d0aee41e0d40881d7ba33
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="dos2unix"
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

	# convert CRLF to LF like in libpluto package
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		DOS2UNIX="$CLANDRO_PKG_TMPDIR/dos2unix"
		(. "$CLANDRO_SCRIPTDIR/packages/dos2unix/build.sh"; CLANDRO_PKG_SRCDIR="$DOS2UNIX" clandro_step_get_source)
		pushd "$DOS2UNIX"
		make dos2unix
		popd # DOS2UNIX
		export PATH="$DOS2UNIX:$PATH"
	fi

	find "$CLANDRO_PKG_SRCDIR" -type f -print0 | xargs -0 dos2unix
}
