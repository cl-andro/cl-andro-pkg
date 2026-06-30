CLANDRO_PKG_HOMEPAGE=https://pagure.io/newt
CLANDRO_PKG_DESCRIPTION="A programming library for color text mode, widget based user interfaces"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.52.25"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://releases.pagure.org/newt/newt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ef0ca9ee27850d1a5c863bb7ff9aa08096c9ed312ece9087b30f3a426828de82
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, slang"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-nls
--without-python
--without-tcl
"
