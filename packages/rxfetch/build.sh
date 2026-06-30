# Contributor: @PeroSar
CLANDRO_PKG_HOMEPAGE=https://github.com/Mangeshrex/rxfetch
CLANDRO_PKG_DESCRIPTION="A custom system info fetching tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=fa70e5aa0eaa72914fc3b170b83a2b67c049cbef
CLANDRO_PKG_VERSION=2023.01.07
CLANDRO_PKG_SRCURL=git+https://github.com/mangeshrex/rxfetch
CLANDRO_PKG_SHA256=c7034d2ab3c591ed048bff33b651d7b3423307b2017336bca215fee1f0878681
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_DEPENDS="bash"
CLANDRO_PKG_CONFLICTS="rxfetch-termux"
CLANDRO_PKG_REPLACES="rxfetch-termux"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout "$_COMMIT"

	local ver=$(git log -1 --format=%cs | sed 's/-/./g')
	if [ "$ver" != "$CLANDRO_PKG_VERSION" ]; then
		echo "Error: Expected version: $ver"
		echo "Found version: $CLANDRO_PKG_VERSION"
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin rxfetch
}
