CLANDRO_PKG_HOMEPAGE=https://wxmaxima-developers.github.io/wxmaxima/
CLANDRO_PKG_DESCRIPTION="A document based interface for the computer algebra system Maxima"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.05.0"
CLANDRO_PKG_SRCURL=https://github.com/wxMaxima-developers/wxmaxima/archive/refs/tags/Version-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1380c58d27e1b2e0eaee543936ca188658a829fc397cb9e064e8803209e3475f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, maxima, wxwidgets"
CLANDRO_PKG_EXCLUDED_ARCHES="i686, x86_64"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DwxWidgets_CONFIG_EXECUTABLE=$CLANDRO_PREFIX/bin/wx-config
-DWXM_INCLUDE_FONTS=OFF
-DWXM_UNIT_TESTS=OFF
"
