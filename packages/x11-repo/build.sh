CLANDRO_PKG_HOMEPAGE=https://github.com/termux/x11-packages
CLANDRO_PKG_DESCRIPTION="Package repository containing X11 programs and libraries"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=8.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="clandro-keyring"
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/apt/sources.list.d
	{
		echo "# The x11 termux repository, with cloudflare cache"
		echo "deb https://cl-andro.github.io/cl-andro-packages/clandro-x11/ x11 main"
		echo "# The x11 termux repository, without cloudflare cache"
		echo "# deb https://cl-andro.github.io/cl-andro-packages/clandro-x11/ x11 main"
	} > $CLANDRO_PREFIX/etc/apt/sources.list.d/x11.list
}

clandro_step_create_debscripts() {
	[ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ] && return 0
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	echo "Downloading updated package list ..."
	if [ -d "$CLANDRO_PREFIX/etc/termux/chosen_mirrors" ] || [ -f "$CLANDRO_PREFIX/etc/termux/chosen_mirrors" ]; then
		pkg --check-mirror update
	else
		apt update
	fi
	exit 0
	EOF
}
