CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
CLANDRO_PKG_DESCRIPTION="An implementation of iconv()"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.18"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libiconv/libiconv-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8
CLANDRO_PKG_BREAKS="libandroid-support (<= 24), libiconv-dev, libandroid-support-dev"
CLANDRO_PKG_REPLACES="libandroid-support (<= 24), libiconv-dev, libandroid-support-dev"

# Enable extra encodings (such as CP437) needed by some programs:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-extra-encodings"
