CLANDRO_PKG_HOMEPAGE=https://computing.llnl.gov/projects/sundials
CLANDRO_PKG_DESCRIPTION="SUite of Nonlinear and DIfferential/ALgebraic equation Solvers."
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:7.7.0"
CLANDRO_PKG_SRCURL=https://github.com/LLNL/sundials/releases/download/v${CLANDRO_PKG_VERSION#*:}/sundials-${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=115bebf25ad0380428e389b8a1a7896725f33cd7c98bbaec8ce2a9ae13812c46
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="suitesparse"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_ARKODE=ON
-DBUILD_CVODE=ON
-DBUILD_CVODES=ON
-DBUILD_IDA=ON
-DBUILD_IDAS=ON
-DBUILD_KINSOL=ON
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DBUILD_FORTRAN_MODULE_INTERFACE=OFF
-DENABLE_KLU=ON
-DKLU_INCLUDE_DIR=$CLANDRO_PREFIX/include/suitesparse
-DKLU_LIBRARY_DIR=$CLANDRO_PREFIX/lib
-DENABLE_OPENMP=ON
-DENABLE_PTHREAD=ON
-DEXAMPLES_INSTALL=OFF
"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_RM_AFTER_INSTALL="examples/"

clandro_step_pre_configure() {
	LDFLAGS+=" -fopenmp -static-openmp"
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libsundials_arkode.so.6
lib/libsundials_core.so.7
lib/libsundials_cvode.so.7
lib/libsundials_cvodes.so.7
lib/libsundials_ida.so.7
lib/libsundials_idas.so.6
lib/libsundials_kinsol.so.7
lib/libsundials_nvecmanyvector.so.7
lib/libsundials_nvecopenmp.so.7
lib/libsundials_nvecpthreads.so.7
lib/libsundials_nvecserial.so.7
lib/libsundials_sunlinsolband.so.5
lib/libsundials_sunlinsoldense.so.5
lib/libsundials_sunlinsolklu.so.5
lib/libsundials_sunlinsolpcg.so.5
lib/libsundials_sunlinsolspbcgs.so.5
lib/libsundials_sunlinsolspfgmr.so.5
lib/libsundials_sunlinsolspgmr.so.5
lib/libsundials_sunlinsolsptfqmr.so.5
lib/libsundials_sunmatrixband.so.5
lib/libsundials_sunmatrixdense.so.5
lib/libsundials_sunmatrixsparse.so.5
lib/libsundials_sunnonlinsolfixedpoint.so.4
lib/libsundials_sunnonlinsolnewton.so.4
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
