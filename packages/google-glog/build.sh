CLANDRO_PKG_HOMEPAGE=https://github.com/google/glog
CLANDRO_PKG_DESCRIPTION="Logging library for C++"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/google/glog/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=00e4a87e87b7e7612f519a41e491f16623b12423620006f59f5688bfd8d13b08
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gflags, libc++"
CLANDRO_PKG_BUILD_DEPENDS="gflags-static"
CLANDRO_PKG_BREAKS="google-glog-dev"
CLANDRO_PKG_REPLACES="google-glog-dev"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^\s*set_target_properties\s*\(glog\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"
}

clandro_step_post_make_install() {
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/libglog.pc.in \
		"$CLANDRO_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@prefix@|$CLANDRO_PREFIX|g" "$CLANDRO_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@exec_prefix@|$CLANDRO_PREFIX|g" "$CLANDRO_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@libdir@|$CLANDRO_PREFIX/lib|g" "$CLANDRO_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@includedir@|$CLANDRO_PREFIX/include|g" "$CLANDRO_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@VERSION@|$CLANDRO_PKG_VERSION|g" "$CLANDRO_PREFIX"/lib/pkgconfig/libglog.pc
}
