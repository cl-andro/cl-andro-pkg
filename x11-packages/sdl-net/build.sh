CLANDRO_PKG_HOMEPAGE=https://www.libsdl.org/projects/SDL_net/
CLANDRO_PKG_DESCRIPTION="A small sample cross-platform networking library"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=3079ee39e1224d744fdedc066280690c8ec40bb1
_COMMIT_DATE=20221115
CLANDRO_PKG_VERSION=1.2.8-p${_COMMIT_DATE}
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/libsdl-org/SDL_net
CLANDRO_PKG_SHA256=9e48bf33b6702b9a570cc8819b69d2aec0d5cfbf410f0ac4ede8e189e216023f
CLANDRO_PKG_GIT_BRANCH=SDL-1.2
CLANDRO_PKG_DEPENDS="sdl"
CLANDRO_PKG_CONFLICTS="libsdl-net"
CLANDRO_PKG_REPLACES="libsdl-net"

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
