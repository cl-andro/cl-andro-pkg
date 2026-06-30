CLANDRO_PKG_HOMEPAGE=https://github.com/yt-dlp/ejs
CLANDRO_PKG_DESCRIPTION="External JavaScript for yt-dlp supporting many runtimes"
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.0"
CLANDRO_PKG_SRCURL="https://github.com/yt-dlp/ejs/releases/download/$CLANDRO_PKG_VERSION/yt_dlp_ejs-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=d5fa1639f63b5c4af8d932495f60689d5370f1a095782c944f7f62a303eb104e
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, hatchling, hatch-vcs"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS='nodejs | nodejs-lts, python'
if (( CLANDRO_ARCH_BITS == 64 )); then
	CLANDRO_PKG_DEPENDS='deno | nodejs | nodejs-lts, python'
fi

clandro_step_make() {
	clandro_setup_nodejs
	npm install --frozen-lockfile
	npm run bundle
	python -m build --wheel --no-isolation
}

clandro_step_make_install() {
	local _whl="yt_dlp_ejs-$CLANDRO_PKG_VERSION-py3-none-any.whl"
	pip install --force-reinstall --no-deps --prefix="$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR/dist/$_whl"
}
