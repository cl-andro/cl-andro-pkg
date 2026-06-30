CLANDRO_PKG_HOMEPAGE=https://www.musicpd.org/libs/libmpdclient/
CLANDRO_PKG_DESCRIPTION="Asynchronous API library for interfacing MPD in the C, C++ & Objective C languages"
CLANDRO_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSES/BSD-2-Clause.txt, LICENSES/BSD-3-Clause.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.24"
CLANDRO_PKG_SRCURL=https://github.com/MusicPlayerDaemon/libmpdclient/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b19ec4c10314f5b55e1bca2a34c299effbbb2f1f9b5113b331b7ba789f0c17d1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BREAKS="libmpdclient-dev"
CLANDRO_PKG_REPLACES="libmpdclient-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Ddefault_socket=${CLANDRO_PREFIX}/var/run/mpd.socket"

clandro_step_pre_configure() {
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _GUARD_FILE="lib/libmpdclient.so.2"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
