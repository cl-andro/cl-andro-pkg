CLANDRO_PKG_HOMEPAGE=https://luarocks.org/
CLANDRO_PKG_DESCRIPTION="Deployment and management system for Lua modules"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.13.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://luarocks.org/releases/luarocks-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=245bf6ec560c042cb8948e3d661189292587c5949104677f1eecddc54dbe7e37
CLANDRO_PKG_AUTO_UPDATE=true
# Do not use varible here since buildorder.py do not evaluate bash before reading.
CLANDRO_PKG_DEPENDS="curl, lua54"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_configure() {
	declare -g __LUA_VERSION=5.4 # Lua version against which it will be built.
	if [ "$CLANDRO_ON_DEVICE_BUILD" != true ]; then
		# Create temporary symlink to workaround luarock bootstrap
		# script trying to run cross-compiled lua
		mv "$CLANDRO_PREFIX"/bin/lua"$__LUA_VERSION"{,.bak}
		ln -sf /usr/bin/lua"$__LUA_VERSION" "$CLANDRO_PREFIX"/bin/lua"$__LUA_VERSION"
	fi

	./configure --prefix="$CLANDRO_PREFIX" \
		--lua-version="$__LUA_VERSION" \
		--with-lua="$CLANDRO_PREFIX"
}

clandro_step_post_make_install() {
	if [ "$CLANDRO_ON_DEVICE_BUILD" != "true" ]; then
		# Restore lua
		unlink "$CLANDRO_PREFIX"/bin/lua"$__LUA_VERSION"
		mv "$CLANDRO_PREFIX"/bin/lua"$__LUA_VERSION"{.bak,}
	fi
}

clandro_step_post_massage() {
	if [ "$CLANDRO_ON_DEVICE_BUILD" != true ]; then
		# Remove lua, due to us moving it back and fourth, the build system
		# thinks it is a newly compiled package.
		rm bin/lua"$__LUA_VERSION"
	fi
}
