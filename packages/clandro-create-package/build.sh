CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/clandro-create-package
CLANDRO_PKG_DESCRIPTION="Utility to create Termux packages"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/cl-andro/clandro-create-package/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=13bcc1264844e9865eeab19805f24ff28bbfac8d39c11bca66f4357fa70e6ace
CLANDRO_PKG_DEPENDS="llvm, python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin src/clandro-create-package
}
