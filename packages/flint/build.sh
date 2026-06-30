CLANDRO_PKG_HOMEPAGE=http://www.flintlib.org
CLANDRO_PKG_DESCRIPTION="C library for doing number theory"
CLANDRO_PKG_LICENSE="LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.0"
CLANDRO_PKG_SRCURL="https://github.com/flintlib/flint/releases/download/v$CLANDRO_PKG_VERSION/flint-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=3982f385f00610a944e0152eb0a29893b2366fa640e8f5f3076c47564cf7e2a6
CLANDRO_PKG_DEPENDS="blas-openblas, libgmp, libmpfr"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_AUTO_UPDATE=true
# ENABLE_ARCH is for adding `-march` argument to compiler; -DENABLE_ARCH=NO avoids that,
# allowing Termux's own `-march` setting from clandro_setup_toolchain_* to apply
# Disable AVX2 like Arch Linux, because Arch Linux documented an issue related to it:
# https://gitlab.archlinux.org/archlinux/packaging/packages/flint/-/work_items/1
# (ENABLE_AVX2=OFF will reportedly be necessary to avoid Sagemath crashing)
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DENABLE_ARCH=NO
-DENABLE_AVX2=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=23

	local v=$(sed -En 's/^FLINT_MAJOR_SO=([0-9]+).*/\1/p' configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed: expected $_SOVERSION, got $v"
	fi
}

clandro_step_pre_configure() {
	# upstream discourages the use of the CMakeLists.txt on UNIX-like platforms,
	# but Arch Linux forcibly runs the CMakeLists.txt anyway using this,
	# so try to follow Arch Linux's example first unless a problem occurs.
	# https://gitlab.archlinux.org/archlinux/packaging/packages/flint/-/blob/0f05d716db948e16d699749ee5c71dab43461857/PKGBUILD#L26
	sed -e 's|NOT WIN32|FALSE|' -i CMakeLists.txt

	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 28 ]]; then
		CPPFLAGS+=" -Daligned_alloc=memalign"
	fi
}
