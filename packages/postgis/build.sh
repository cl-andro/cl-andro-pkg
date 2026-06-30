CLANDRO_PKG_HOMEPAGE=https://postgis.net
CLANDRO_PKG_DESCRIPTION="Spatial database extender for PostgreSQL object-relational database"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.6.3"
CLANDRO_PKG_SRCURL="https://download.osgeo.org/postgis/source/postgis-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=58ff19ae133e470280efb4949ef92e0364d4c2a66bef8c57e69477348d815ea3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdal, json-c, libc++, libgeos, libiconv, libprotobuf-c, libxml2, pcre2, postgresql, proj"

# both configure script and Makefile(s) look for files in current
# directory rather than srcdir, so need to build in source
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CPPFLAGS+=" -D_GNU_SOURCE" # for preadv and pwritev
	CXXFLAGS+=" -std=c++14"
}
