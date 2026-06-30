CLANDRO_PKG_HOMEPAGE=https://ninja-build.org
CLANDRO_PKG_DESCRIPTION="A small build system with a focus on speed"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.2"
CLANDRO_PKG_SRCURL=https://github.com/ninja-build/ninja/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=974d6b2f4eeefa25625d34da3cb36bdcebe7fbce40f4c16ac0835fd1c0cbae17
CLANDRO_PKG_DEPENDS="libandroid-spawn, libc++"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-spawn"
}

clandro_step_configure() {
	$CLANDRO_PKG_SRCDIR/configure.py
}

clandro_step_make() {
	if $CLANDRO_ON_DEVICE_BUILD; then
		$CLANDRO_PKG_SRCDIR/configure.py --bootstrap
	else
		clandro_setup_ninja
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES
	fi
}

clandro_step_make_install() {
	cp ninja $CLANDRO_PREFIX/bin
}
