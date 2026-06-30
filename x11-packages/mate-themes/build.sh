CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Official themes for the MATE desktop"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.22.26"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-themes/releases/download/v$CLANDRO_PKG_VERSION/mate-themes-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=224e89d364eb3b73f1cf756d05494a98421a93cbf54349a2c85fc607eb755ed7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common"
CLANDRO_PKG_RECOMMENDS="mate-icon-theme"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	# Remove check for gtk2
	sed -i '/Check GTK+ theme engines/,+3d' configure.ac

	autoreconf -fi
}
