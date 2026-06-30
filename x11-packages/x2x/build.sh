CLANDRO_PKG_HOMEPAGE=https://github.com/dottedmag/x2x
CLANDRO_PKG_DESCRIPTION="Allows the keyboard, mouse on one X display to be used to control another X display"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:1.30-10
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/dottedmag/x2x/archive/refs/tags/debian/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=f41d5ed55d4b05fe28ab8c07bf41e19cdafcc6ecd08f588679aa0ee48f1eb627
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libx11, libxext, libxtst"

clandro_step_pre_configure() {
	./bootstrap.sh
}
