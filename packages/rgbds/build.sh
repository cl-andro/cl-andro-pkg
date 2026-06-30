CLANDRO_PKG_HOMEPAGE=https://rgbds.gbdev.io
CLANDRO_PKG_DESCRIPTION="Rednex Game Boy Development System - An assembly toolchain for the Nintendo Game Boy & Game Boy Color"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.1"
CLANDRO_PKG_SRCURL=https://github.com/gbdev/rgbds/releases/download/v${CLANDRO_PKG_VERSION}/rgbds-source.tar.gz
CLANDRO_PKG_SHA256=0bb80f6aaecc3ac173758686021a98cbb941aa0829124985f977ba8da4e48b21
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-spawn, libandroid-support, libc++, libpng"

clandro_step_pre_configure() {
	export LDFLAGS+=" -landroid-spawn"
}
