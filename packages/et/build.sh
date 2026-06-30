CLANDRO_PKG_HOMEPAGE=https://eternalterminal.dev
CLANDRO_PKG_DESCRIPTION="A remote shell that automatically reconnects without interrupting the session"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.2.11"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/MisterTea/EternalTerminal
CLANDRO_PKG_GIT_BRANCH=et-v${CLANDRO_PKG_VERSION}
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="abseil-cpp, libc++, libsodium, openssl, protobuf, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DDISABLE_VCPKG=1"

clandro_step_pre_configure() {
	clandro_setup_protobuf
}

clandro_step_post_make_install() {
	install -Dm600 $CLANDRO_PKG_SRCDIR/etc/et.cfg $CLANDRO_PREFIX/etc/
}
