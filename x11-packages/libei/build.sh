CLANDRO_PKG_HOMEPAGE=https://libinput.pages.freedesktop.org/libei/
CLANDRO_PKG_DESCRIPTION="Library for Emulated Input"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.0"
CLANDRO_PKG_SRCURL="https://gitlab.freedesktop.org/libinput/libei/-/archive/$CLANDRO_PKG_VERSION/libei-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=7687c3bbcff89ff331c5db72e0a5cce6bcae382e3c238d6f7019a6bc71d88e43
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibei=enabled
-Dlibeis=enabled
-Dliboeffis=disabled
-Dtests=disabled
"

clandro_step_pre_configure() {
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libei.so.1
lib/libeis.so.1
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
