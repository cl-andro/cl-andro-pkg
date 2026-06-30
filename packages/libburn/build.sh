CLANDRO_PKG_HOMEPAGE=https://dev.lovelyhq.com/libburnia
CLANDRO_PKG_DESCRIPTION="Library for reading, mastering and writing optical discs"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.8"
CLANDRO_PKG_SRCURL=https://files.libburnia-project.org/releases/libburn-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=8e24dd99f5b7cafbecf0116d61b619ee89098e20263e6f47c793aaf4a98d6473
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libburn-dev"
CLANDRO_PKG_REPLACES="libburn-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
