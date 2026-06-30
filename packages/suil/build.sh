CLANDRO_PKG_HOMEPAGE=https://drobilla.net/software/suil.html
CLANDRO_PKG_DESCRIPTION="A library for loading and wrapping LV2 plugin UIs"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.26"
CLANDRO_PKG_SRCURL=https://download.drobilla.net/suil-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=62808916602c47d201a1ec2d246323a8048243f2bf972f859f0db1db4662ee43
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="lv2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk2=disabled
-Dgtk3=disabled
-Dqt5=disabled
-Dx11=disabled
-Ddocs=disabled
"
