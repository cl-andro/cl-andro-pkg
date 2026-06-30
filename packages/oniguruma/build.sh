CLANDRO_PKG_HOMEPAGE=https://github.com/kkos/oniguruma
CLANDRO_PKG_DESCRIPTION="Regular expressions library"
CLANDRO_PKG_VERSION="6.9.10"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/kkos/oniguruma/releases/download/v$CLANDRO_PKG_VERSION/onig-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2a5cfc5ae259e4e97f86b68dfffc152cdaffe94e2060b770cb827238d769fc05
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^LTVERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
