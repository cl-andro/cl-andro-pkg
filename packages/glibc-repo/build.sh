CLANDRO_PKG_HOMEPAGE=https://github.com/termux/glibc-packages
CLANDRO_PKG_DESCRIPTION="A package repository containing glibc-based programs and libraries"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@termux-pacman & @clandro"
CLANDRO_PKG_VERSION=1.0
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/apt/sources.list.d
	{
		echo "# The glibc termux repository, with cloudflare cache"
		echo "deb https://cl-andro.github.io/cl-andro-packages/clandro-glibc/ glibc stable"
		echo "# The glibc termux repository, without cloudflare cache"
		echo "# deb https://cl-andro.github.io/cl-andro-packages/clandro-glibc/ glibc stable"
	} > $CLANDRO_PREFIX/etc/apt/sources.list.d/glibc.list
}

clandro_step_create_debscripts() {
	[ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ] && return 0
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}
