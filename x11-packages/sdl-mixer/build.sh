CLANDRO_PKG_HOMEPAGE=https://www.libsdl.org/projects/SDL_mixer/release-1.2.html
CLANDRO_PKG_DESCRIPTION="A simple multi-channel audio mixer"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=7804621c533dddfe970e97c94c4ea72d48ed7f48
_COMMIT_DATE=20221010
CLANDRO_PKG_VERSION=1.2.12-p${_COMMIT_DATE}
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/libsdl-org/SDL_mixer
CLANDRO_PKG_SHA256=473a39b04f1a2ec29a22e3eafaafeee9704129f117044d17c591646648b540cd
CLANDRO_PKG_GIT_BRANCH=SDL-1.2
CLANDRO_PKG_DEPENDS="libflac, libvorbis, sdl"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$CLANDRO_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$CLANDRO_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}
