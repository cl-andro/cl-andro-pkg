CLANDRO_PKG_HOMEPAGE=https://tukaani.org/xz/
CLANDRO_PKG_DESCRIPTION="XZ-format compression library"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0, GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.GPLv2, COPYING.GPLv3, COPYING.LGPLv2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.8.3"
CLANDRO_PKG_SRCURL=https://github.com/tukaani-project/xz/releases/download/v$CLANDRO_PKG_VERSION/xz-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=fff1ffcf2b0da84d308a14de513a1aa23d4e9aa3464d17e64b9714bfdd0bbfb6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="liblzma-dev"
CLANDRO_PKG_REPLACES="liblzma-dev"
CLANDRO_PKG_ESSENTIAL=true
# seccomp prevents SYS_landlock_create_ruleset
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-sandbox=no
"

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/liblzma.so.5"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done

	# Check if SONAME is properly set:
	if ! readelf -d lib/liblzma.so | grep -q '(SONAME).*\[liblzma\.so\.'; then
		clandro_error_exit "SONAME of liblzma.so is not properly set."
	fi
}
