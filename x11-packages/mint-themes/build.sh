CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/mint-themes
CLANDRO_PKG_DESCRIPTION="Mint Mint-X, Mint-Y for cinnamon"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.9"
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/mint-themes/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=313c10ec5cb776eb10068079e9ff384fb1de4351f23a13ee2452592957bc01de
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="pysass"
CLANDRO_PKG_BUILD_DEPENDS="python-libsass"
CLANDRO_PKG_SUGGESTS="mint-x-icon-theme, mint-y-icon-theme"

clandro_step_pre_configure() {
	# allow use of GNU/Linux pysass (CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="pysass") during cross-compilation
	# but bionic-libc pysass (CLANDRO_PKG_BUILD_DEPENDS="python-sass") during on-device build
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PYTHONPATH="${CLANDRO_PYTHON_CROSSENV_PREFIX}/cross/lib/python${CLANDRO_PYTHON_VERSION}/site-packages"
	fi
}

clandro_step_make() {
	cd $CLANDRO_PKG_SRCDIR
	make -j$CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/themes/
	cp -r $CLANDRO_PKG_SRCDIR/usr/share/themes/* $CLANDRO_PREFIX/share/themes/
}
