CLANDRO_PKG_HOMEPAGE=http://openbabel.org/wiki/Main_Page
CLANDRO_PKG_DESCRIPTION="Open Babel is a chemical toolbox designed to speak the many languages of chemical data"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.1"
CLANDRO_PKG_REVISION=14
CLANDRO_PKG_SRCURL="https://github.com/openbabel/openbabel/archive/refs/tags/openbabel-${CLANDRO_PKG_VERSION//./-}.tar.gz"
CLANDRO_PKG_SHA256=c97023ac6300d26176c97d4ef39957f06e68848d64f1a04b0b284ccff2744f02
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libcairo, libxml2, rapidjson, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, eigen"
CLANDRO_PKG_BREAKS="openbabel-dev"
CLANDRO_PKG_REPLACES="openbabel-dev"
CLANDRO_PKG_GROUPS="science"
# MAEPARSER gives an error related to boost's unit_test_framework during configure
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_MAEPARSER=off -DWITH_COORDGEN=off"
