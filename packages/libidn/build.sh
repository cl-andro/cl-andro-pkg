CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/libidn/
CLANDRO_PKG_DESCRIPTION="GNU Libidn library, implementation of IETF IDN specifications"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-3.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.43"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libidn/libidn-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bdc662c12d041b2539d0e638f3a6e741130cdb33a644ef3496963a443482d164
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libiconv"
CLANDRO_PKG_BREAKS="libidn-dev"
CLANDRO_PKG_REPLACES="libidn-dev"

# Remove the idn tool for now, add it as subpackage if desired::
CLANDRO_PKG_RM_AFTER_INSTALL="bin/idn share/man/man1/idn.1 share/emacs"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-ld-version-script"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=12

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
