CLANDRO_PKG_HOMEPAGE=https://github.com/termux/command-not-found
CLANDRO_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION=3.4.1
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://github.com/termux/command-not-found/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8dfec3aeb340d2359bf8c0b220497128f4b17bcb3967e4fd64f7a46773b40a3e
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	export CLANDRO_PREFIX
	export CLANDRO_SCRIPTDIR
	clandro_setup_nodejs
}
