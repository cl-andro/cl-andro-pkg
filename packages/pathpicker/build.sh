CLANDRO_PKG_HOMEPAGE=https://facebook.github.io/PathPicker/
CLANDRO_PKG_DESCRIPTION="Facebook PathPicker - a terminal-based file picker"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.5"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/facebook/PathPicker/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b0142676ed791085d619d9b3d28d28cab989ffc3b260016766841c70c97c2a52
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	_PKG_DIR=$CLANDRO_PREFIX/share/pathpicker
	rm -Rf $_PKG_DIR src/tests
	mkdir -p $_PKG_DIR
	cp -Rf src/ $_PKG_DIR
	cp fpp $_PKG_DIR/fpp
	cd $CLANDRO_PREFIX/bin
	ln -f -s ../share/pathpicker/fpp fpp
	chmod +x fpp
}
