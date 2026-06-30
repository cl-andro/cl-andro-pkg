CLANDRO_PKG_HOMEPAGE=https://github.com/keshavbhatt/olivia
CLANDRO_PKG_DESCRIPTION="Elegant music player for LINUX"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=4048134f7df91dc9368147d9aac25f408d6ecb59
CLANDRO_PKG_VERSION=2022.10.20
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/keshavbhatt/olivia
CLANDRO_PKG_SHA256=71994c6c9821f7bdf3560c308e3b0b1b27799b497f0ca9cf93969fbf998289ea
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="coreutils, libc++, mpv, python, qt5-qtbase, qt5-qtwebkit, socat, taglib, wget"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$CLANDRO_PREFIX
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

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/src"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
}

clandro_step_configure() {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
}
