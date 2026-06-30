CLANDRO_PKG_HOMEPAGE=https://www.unidata.ucar.edu/software/netcdf/
CLANDRO_PKG_DESCRIPTION="NetCDF is a set of software libraries and self-describing, machine-independent data formats that support the creation, access, and sharing of array-oriented scientific data"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="4.10.0"
CLANDRO_PKG_SRCURL="https://github.com/Unidata/netcdf-c/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ce160f9c1483b32d1ba8b7633d7984510259e4e439c48a218b95a023dc02fd4c
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libcurl, zlib"
CLANDRO_PKG_BREAKS="netcdf-c-dev"
CLANDRO_PKG_REPLACES="netcdf-c-dev"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-hdf5"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="gdal (<= 3.10.2), monetdb (<= 11.51.7)"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION="24-2"

	local e=$(sed -En 's/.*\s+netCDF_SO_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "${e}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
