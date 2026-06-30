CLANDRO_PKG_HOMEPAGE=https://www.gaia-gis.it/fossil/libspatialite
CLANDRO_PKG_DESCRIPTION="SQLite extension to support spatial data types and operations"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.1.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=43be2dd349daffe016dd1400c5d11285828c22fea35ca5109f21f3ed50605080
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgeos, proj, libfreexl, libsqlite, libxml2, librttopo"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-minizip"
# Can't find generated config file spatialite/gaiaconfig.h
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export LDFLAGS+=" -llog"
}
