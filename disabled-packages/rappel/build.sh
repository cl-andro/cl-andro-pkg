CLANDRO_PKG_HOMEPAGE=https://github.com/yrp604/rappel
CLANDRO_PKG_DESCRIPTION="Rappel is a pretty janky assembly REPL"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=b848fce5e3759f3cbeda55e3cd8dcd7321525a44
CLANDRO_PKG_VERSION=2022.11.07
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/yrp604/rappel
CLANDRO_PKG_SHA256=e3dfe84e88b7711918555e40cb88f723ee99f197795193cd5620367b29f4a56e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="binutils-is-llvm | binutils, libedit"
CLANDRO_PKG_BUILD_IN_SRC=true

# Need nasm.
CLANDRO_PKG_EXCLUDED_ARCHES="i686, x86_64"

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

clandro_step_make() {
	local _ARCH

	if [ "$CLANDRO_ARCH" = "i686" ]; then
		_ARCH="x86"
	elif [ "$CLANDRO_ARCH" = "x86_64" ]; then
		_ARCH="amd64"
	elif [ "$CLANDRO_ARCH" = "arm" ]; then
		_ARCH="armv7"
	elif [ "$CLANDRO_ARCH" = "aarch64" ]; then
		_ARCH="armv8"
	else
		_ARCH=$CLANDRO_ARCH
	fi

	make ARCH=$_ARCH CC="$CC $CPPFLAGS $CFLAGS" LDFLAGS="$LDFLAGS" -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make_install() {
	cd bin
	install -Dm755 -t "$CLANDRO_PREFIX/bin" rappel
}
