CLANDRO_PKG_HOMEPAGE="https://github.com/michaelforney/samurai"
CLANDRO_PKG_DESCRIPTION="ninja-compatible build tool written in C"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3"
CLANDRO_PKG_SRCURL="https://github.com/michaelforney/samurai/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=44ff119a27b343ec47a797fa8701c19b9e672230bc15f3c6a6cede9641ea6332
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-spawn"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	rm -f "build.ninja"
	export LDFLAGS+=" -landroid-spawn"
}
