CLANDRO_PKG_HOMEPAGE=https://github.com/HOST-Oman/libraqm
CLANDRO_PKG_DESCRIPTION="Raqm is a small library that encapsulates the logic for complex text layout and provides a convenient API"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.5"
CLANDRO_PKG_SRCURL=https://github.com/HOST-Oman/libraqm/releases/download/v$CLANDRO_PKG_VERSION/raqm-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=563053e724892a7b037913110ea2daef50ad575d4fa9f7c368ae1e4515f5e856
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, harfbuzz, fribidi"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
