CLANDRO_PKG_HOMEPAGE=https://gitlab.com/osm-c-tools/osmctools
CLANDRO_PKG_DESCRIPTION="Simple tools for OpenStreetMap processing"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.9
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://gitlab.com/osm-c-tools/osmctools/-/archive/${CLANDRO_PKG_VERSION}/osmctools-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2f5298be5b4ba840a04f360c163849b34a31386ccd287657885e21268665f413
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_GROUPS="science"

clandro_step_pre_configure () {
	autoreconf --install
}
