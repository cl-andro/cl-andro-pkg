CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Mixer library for MATE Desktop"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/libmatemixer/releases/download/v$CLANDRO_PKG_VERSION/libmatemixer-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=5d73b922397f60688e3c9530eb532bce46c30e262db1b5352fa32c40d870a0c7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="alsa-lib, glib, pulseaudio"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--localstatedir=$CLANDRO_PREFIX/var
"
