CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/units/
CLANDRO_PKG_DESCRIPTION="Converts between different systems of units"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.27"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/units/units-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e1bbdb09672e7c08eee986749e7a1629eb84a6bdf41f5a2a79d6804444abbe10
CLANDRO_PKG_DEPENDS="readline, libandroid-support"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sharedstatedir=$CLANDRO_PREFIX/var/lib
"
