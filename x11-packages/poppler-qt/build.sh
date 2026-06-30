CLANDRO_PKG_HOMEPAGE=https://poppler.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Poppler Qt wrapper"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Please align the version with `poppler` package.
CLANDRO_PKG_VERSION="26.02.0"
CLANDRO_PKG_SRCURL="https://poppler.freedesktop.org/poppler-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=dded8621f7b2f695c91063aab1558691c8418374cd583501e89ed39487e7ab77
# The package must be updated at the same time as poppler, auto updater script does not support that.
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="freetype, libc++, littlecms, poppler (>= ${CLANDRO_PKG_VERSION}), qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, qt6-qtbase-cross-tools"
#texlive needs the xpdf headers
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GLIB=ON
-DENABLE_GOBJECT_INTROSPECTION=OFF
-DENABLE_UNSTABLE_API_ABI_HEADERS=ON
-DENABLE_QT5=OFF
-DENABLE_QT6=ON
-DFONT_CONFIGURATION=fontconfig
"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# when SOVERSION is changed.
	local _POPPLER_SOVERSION=157
	if ! test "${_POPPLER_SOVERSION}"; then
		clandro_error_exit "Please set _POPPLER_SOVERSION variable."
	fi
	local sover_main=$(. $CLANDRO_SCRIPTDIR/packages/poppler/build.sh; echo $_POPPLER_SOVERSION)
	if [ "${sover_main}" != "${_POPPLER_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION mismatch with \"poppler\" package."
	fi
	local sover_cmake=$(sed -En 's/^set\(POPPLER_SOVERSION_NUMBER "([0-9]+)"\)$/\1/p' CMakeLists.txt)
	if [ "${sover_cmake}" != "${_POPPLER_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed (CMakeLists.txt: \"${sover_cmake}\")."
	fi

	CPPFLAGS+=" -DCMS_NO_REGISTER_KEYWORD"
}

clandro_step_make_install() {
	cmake --build "${CLANDRO_PKG_BUILDDIR}" --target qt6/install
	install -Dm600 -t "${CLANDRO_PREFIX}"/lib/pkgconfig "${CLANDRO_PKG_BUILDDIR}"/poppler-qt6.pc
}
