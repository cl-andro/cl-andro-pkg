CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/libidn/#libidn2
CLANDRO_PKG_DESCRIPTION="Free software implementation of IDNA2008, Punycode and TR46"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-2.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.8"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libidn/libidn2-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f557911bf6171621e1f72ff35f5b1825bb35b52ed45325dcdee931e5d3c0787a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv, libunistring"
CLANDRO_PKG_BREAKS="libidn2-dev"
CLANDRO_PKG_REPLACES="libidn2-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^AC_SUBST\('"${a}"',\s*([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
