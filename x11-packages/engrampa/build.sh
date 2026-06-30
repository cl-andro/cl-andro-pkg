CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="File archiver for MATE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.3"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/engrampa/releases/download/v$CLANDRO_PKG_VERSION/engrampa-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=d01b119981a3947f2072ef88319eca0f58600ff81dc933b5f4a7d8f0eb72e916
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gtk3, gzip, gettext, libarchive, tar, unzip, zip"
CLANDRO_PKG_RECOMMENDS="caja, p7zip, unrar, brotli, rpm, cpio"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, caja, glib, mate-common, python"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-packagekit
"
