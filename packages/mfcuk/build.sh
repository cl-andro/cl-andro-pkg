CLANDRO_PKG_HOMEPAGE=https://github.com/nfc-tools/mfcuk
CLANDRO_PKG_DESCRIPTION="MiFare Classic Universal toolKit (MFCUK)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=b333a7925a3be80d9496c88c9fef816777827a83
CLANDRO_PKG_VERSION=2018.07.14
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/nfc-tools/mfcuk
CLANDRO_PKG_SHA256=1ceec471a8cd0cfb50dd19e022f7f019bb2892285c9354403c98d5b0f94ef9af
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libnfc"

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
	autoreconf -fi
}
