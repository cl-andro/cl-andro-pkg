CLANDRO_PKG_HOMEPAGE=https://www.winimage.com/zLibDll/minizip.html
CLANDRO_PKG_DESCRIPTION="Mini zip and unzip based on zlib"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="MiniZip64_info.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/madler/zlib/releases/download/v${CLANDRO_PKG_VERSION}/zlib-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=d7a0654783a4da529d1bb793b7ad9c3318020af77667bcae35f95d0e42a792f3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="zlib"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/contrib/minizip"
	cd $CLANDRO_PKG_SRCDIR
	autoreconf -fi
}
