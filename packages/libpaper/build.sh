CLANDRO_PKG_HOMEPAGE=https://github.com/rrthomas/psutils
CLANDRO_PKG_DESCRIPTION="Library for handling paper characteristics (by @rrthomas)"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.2.7"
CLANDRO_PKG_SRCURL="https://github.com/rrthomas/libpaper/releases/download/v${CLANDRO_PKG_VERSION}/libpaper-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=3925401edf1eda596277bc2485e050b704fd7f364f257c874b0c40ac5aa627c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=${CLANDRO_PREFIX}/etc
--enable-relocatable
"
CLANDRO_PKG_PROVIDES="paper"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi

}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		mkdir -p ${CLANDRO_PREFIX}/etc/paper.d
	EOF
}
