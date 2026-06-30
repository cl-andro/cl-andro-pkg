CLANDRO_PKG_HOMEPAGE=https://github.com/wg/wrk
CLANDRO_PKG_DESCRIPTION="Modern HTTP benchmarking tool"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.2.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/wg/wrk/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e255f696bff6e329f5d19091da6b06164b8d59d62cb9e673625bdcd27fe7bdad
CLANDRO_PKG_DEPENDS="openssl, luajit"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_make() {
	local _ARCH

	if [ "$CLANDRO_ARCH" = "i686" ]; then
		_ARCH="x86"
	elif [ "$CLANDRO_ARCH" = "x86_64" ]; then
		_ARCH="x64"
	elif [ "$CLANDRO_ARCH" = "aarch64" ]; then
		_ARCH="arm64"
	else
		_ARCH=$CLANDRO_ARCH
	fi

	make WITH_OPENSSL=$CLANDRO_PREFIX WITH_LUAJIT=$CLANDRO_PREFIX _ARCH=$_ARCH
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin wrk
	install -Dm600 -t "$CLANDRO_PREFIX"/share/doc/wrk/examples/ scripts/*.lua
	install -Dm600 -t "$CLANDRO_PREFIX"/share/lua/5.1/ src/wrk.lua
}
