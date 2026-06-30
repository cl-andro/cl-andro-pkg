CLANDRO_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
CLANDRO_PKG_DESCRIPTION="Command-line utility for reading information from media files"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="../../../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.01"
CLANDRO_PKG_SRCURL=https://github.com/MediaArea/MediaInfo/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cec53d8aa143376965d8da72cfaaed4e1e432e23a19ed26cbdf8e69a14e93365
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libc++, libmediainfo, libzen"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR="${CLANDRO_PKG_SRCDIR}/Project/GNU/CLI"
	CLANDRO_PKG_BUILDDIR="${CLANDRO_PKG_SRCDIR}"
	cd "${CLANDRO_PKG_SRCDIR}"
	./autogen.sh
}
