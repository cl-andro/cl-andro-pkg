CLANDRO_PKG_HOMEPAGE=https://github.com/mpimd-csc/qrupdate-ng
CLANDRO_PKG_DESCRIPTION="A Library for Fast Updating of QR and Cholesky Decompositions."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:1.1.5"
CLANDRO_PKG_SRCURL=https://github.com/mpimd-csc/qrupdate-ng/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=912426f7cb9436bb3490c3102a64d9a2c3883d700268a26d4d738b7607903757
CLANDRO_PKG_DEPENDS="libopenblas"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
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
lib/libqrupdate.so.1
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
