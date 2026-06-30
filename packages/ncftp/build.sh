CLANDRO_PKG_HOMEPAGE=https://www.ncftp.com/
CLANDRO_PKG_DESCRIPTION="A free set of programs that use the File Transfer Protocol"
# License: Clarified Artistic
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="doc/LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.ncftp.com/public_ftp/ncftp/ncftp-${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=7920f884c2adafc82c8e41c46d6f3d22698785c7b3f56f5677a8d5c866396386
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses, resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"

	export ac_cv_path_TAR=$CLANDRO_PREFIX/bin/tar
}
