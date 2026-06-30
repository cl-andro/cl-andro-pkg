CLANDRO_PKG_HOMEPAGE=https://gdal.org
CLANDRO_PKG_DESCRIPTION="A translator library for raster and vector geospatial data formats"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.TXT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.12.4"
CLANDRO_PKG_SRCURL="https://download.osgeo.org/gdal/${CLANDRO_PKG_VERSION}/gdal-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=813094498c17522ac42821a5ea1ea783d8326c0adf286cce86a949038bd09198
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="giflib, json-c, libc++, libcurl, libexpat, libfreexl, libgeos, libiconv, libjpeg-turbo, libjxl, liblzma, libpng, libspatialite, libsqlite, libwebp, libxml2, netcdf-c (>= 4.9.3), openjpeg, openssl, postgresql, proj, xerces-c, zlib, zstd"
CLANDRO_PKG_BUILD_DEPENDS="json-c-static"
CLANDRO_PKG_BREAKS="gdal-dev"
CLANDRO_PKG_REPLACES="gdal-dev"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DGDAL_USE_JXL=ON
-DGDAL_USE_TIFF_INTERNAL=ON
-DGDAL_USE_GEOTIFF_INTERNAL=ON
-DBUILD_PYTHON_BINDINGS=OFF
-DBUILD_JAVA_BINDINGS=OFF
"

clandro_step_pre_configure () {
	if [[ "${CLANDRO_ARCH}" == "arm" ]]; then
		## -mfpu=neon causes build failure on ARM.
		CFLAGS="${CFLAGS/-mfpu=neon/} -mfpu=vfp"
		CXXFLAGS="${CXXFLAGS/-mfpu=neon/} -mfpu=vfp"
	fi
}
