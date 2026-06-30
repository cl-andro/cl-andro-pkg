CLANDRO_PKG_HOMEPAGE=http://www.underbit.com/products/mad/
CLANDRO_PKG_DESCRIPTION="MAD is a high-quality MPEG audio decoder"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://codeberg.org/tenacityteam/libmad/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f4eb229452252600ce48f3c2704c9e6d97b789f81e31c37b0c67dd66f445ea35
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libmad-dev"
CLANDRO_PKG_REPLACES="libmad-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DCMAKE_SYSTEM_NAME=Linux
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libmad.so.0"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
