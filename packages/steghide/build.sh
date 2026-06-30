CLANDRO_PKG_HOMEPAGE=https://steghide.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Embeds a message in a file by replacing some of the least significant bits"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.1
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/steghide/steghide-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=78069b7cfe9d1f5348ae43f918f06f91d783c2b3ff25af021e6a312cf541b47b
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++, libjpeg-turbo, libmcrypt, libmhash, zlib"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__dev_random=yes
ac_cv_file__dev_urandom=yes
--mandir=$CLANDRO_PREFIX/share/man
"
