CLANDRO_PKG_HOMEPAGE=https://tox.chat
CLANDRO_PKG_DESCRIPTION="Backend library for the Tox protocol"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Match commit SHA with toxic/blob/master/script/build-minimal-static-toxic.sh
# (for example, toxic 0.16.2 has the commit of c-toxcore version 0.2.22 in it)
# https://github.com/JFreegman/toxic/blob/07dba324aa06916c6c96ed5104240d304a662050/script/build-minimal-static-toxic.sh#L146
CLANDRO_PKG_VERSION="0.2.22"
CLANDRO_PKG_SRCURL="https://github.com/TokTok/c-toxcore/releases/download/v$CLANDRO_PKG_VERSION/c-toxcore-v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=276d447eb94e9d76e802cecc5ca7660c6c15128a83dfbe4353b678972aeb950a
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_DEPENDS="libsodium, libopus, libvpx"
CLANDRO_PKG_BREAKS="c-toxcore-dev"
CLANDRO_PKG_REPLACES="c-toxcore-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DBOOTSTRAP_DAEMON=off
-DDHT_BOOTSTRAP=off
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				so.version)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
