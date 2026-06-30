CLANDRO_PKG_HOMEPAGE=https://www.openimagedenoise.org
CLANDRO_PKG_DESCRIPTION="Intel® Open Image Denoise library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.1"
CLANDRO_PKG_SRCURL="https://github.com/OpenImageDenoise/oidn/releases/download/v$CLANDRO_PKG_VERSION/oidn-$CLANDRO_PKG_VERSION.src.tar.gz"
CLANDRO_PKG_SHA256=9c7c77ae0d57e004479cddb7aaafd405c2cc745153bed4805413c21be610e17b
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++, libllvm, libtbb"
# OIDN supports 64-bit platforms only,
# see https://github.com/OpenImageDenoise/oidn/#prerequisites.
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_pre_configure() {
	local ISPC_VERSION=1.30.0
	local ISPC_URL="https://github.com/ispc/ispc/releases/download/v$ISPC_VERSION/ispc-v$ISPC_VERSION-linux.tar.gz"
	local ISPC_TARFILE="$CLANDRO_PKG_CACHEDIR/$(basename $ISPC_URL)"
	local ISPC_SHA256=63e7d61037849fa1ed644f0398d21740ee9f880b9bf81f017c65eebe1d42c02b
	clandro_download "$ISPC_URL" "$ISPC_TARFILE" "$ISPC_SHA256"
	if [[ ! -e "$CLANDRO_PKG_CACHEDIR/.placeholder-ispc-v$ISPC_VERSION" ]]; then
		rm -rf "$CLANDRO_PKG_CACHEDIR/ispc-v$ISPC_VERSION-linux"
		tar -xvf "$ISPC_TARFILE" -C "$CLANDRO_PKG_CACHEDIR"
		touch "$CLANDRO_PKG_CACHEDIR/.placeholder-ispc-v$ISPC_VERSION"
	fi
	export PATH="$CLANDRO_PKG_CACHEDIR/ispc-v$ISPC_VERSION-linux/bin:$PATH"
	LDFLAGS+=" -llog"
}
