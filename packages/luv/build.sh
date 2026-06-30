CLANDRO_PKG_HOMEPAGE=https://github.com/luvit/luv
CLANDRO_PKG_DESCRIPTION="Bare libuv bindings for lua"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.52.1-0"
CLANDRO_PKG_SRCURL=https://github.com/luvit/luv/releases/download/$CLANDRO_PKG_VERSION/luv-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3e6eb820a3aee034f85f9cce9bd77b5d42f34d128a1ccec877adf28c913577c7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libuv, luajit"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_MODULE=OFF
-DBUILD_SHARED_LIBS=ON
-DLUA_BUILD_TYPE=System
-DLUAJIT_INCLUDE_DIR=$CLANDRO_PREFIX/include/luajit-2.1
-DLUA_PACKAGE_DIR=$CLANDRO_PREFIX/lib/lua/5.1
-DWITH_LUA_ENGINE=LuaJit
-DWITH_SHARED_LIBUV=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(sed -En 's/^set\(LUV_VERSION_MAJOR\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	export LDFLAGS+=" -L$CLANDRO_PREFIX/lib/lua/5.1"
}
