CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="MATE default icon theme"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-icon-theme/releases/download/v$CLANDRO_PKG_VERSION/mate-icon-theme-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=94d6079060ca5df74542921de4eea38b7d02d07561c919356d95de876f9a6d3a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="mate-common, icon-naming-utils"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi
	# XML::Simple for running $CLANDRO_PREFIX/libexec/icon-name-mapping in
	# the Ubuntu termux-package-builder's perl during cross-compilation
	clandro_download_ubuntu_packages libxml-simple-perl
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PERL5LIB="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/share/perl5"
	fi
}
