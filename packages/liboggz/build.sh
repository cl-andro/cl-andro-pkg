CLANDRO_PKG_HOMEPAGE=https://www.xiph.org/oggz/
CLANDRO_PKG_DESCRIPTION="Command and library to inspect, tweak, edit and validate Ogg files"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.xiph.org/releases/liboggz/liboggz-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2466d03b67ef0bcba0e10fb352d1a9ffd9f96911657abce3cbb6ba429c656e2f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libogg"
CLANDRO_PKG_BREAKS="liboggz-dev"
CLANDRO_PKG_REPLACES="liboggz-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"
