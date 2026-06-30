CLANDRO_PKG_HOMEPAGE=https://github.com/opencollab/arpack-ng
CLANDRO_PKG_DESCRIPTION="Collection of Fortran77 subroutines designed to solve large scale eigenvalue problems."
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:3.9.1"
CLANDRO_PKG_SRCURL=https://github.com/opencollab/arpack-ng/archive/refs/tags/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=f6641deb07fa69165b7815de9008af3ea47eb39b2bb97521fbf74c97aba6e844
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libopenblas"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_pre_configure() {
	clandro_setup_flang
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libarpack.so.2
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
