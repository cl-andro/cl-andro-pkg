CLANDRO_PKG_HOMEPAGE=https://github.com/libass/libass
CLANDRO_PKG_DESCRIPTION="A portable library for SSA/ASS subtitles rendering"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.17.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libass/libass/releases/download/$CLANDRO_PKG_VERSION/libass-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=78f1179b838d025e9c26e8fef33f8092f65611444ffa1bfc0cfac6a33511a05a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, fribidi, glib, harfbuzz"
CLANDRO_PKG_BREAKS="libass-dev"
CLANDRO_PKG_REPLACES="libass-dev"
# Avoid text relocations.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_prog_nasm_check=no"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^LIBASS_'"${a}"'\s+=\s+([0-9]+).*/\1/p' \
				libass/Makefile_library.am)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
