CLANDRO_PKG_HOMEPAGE=https://github.com/termux-user-repository/tur
CLANDRO_PKG_DESCRIPTION="A single and trusted place for all unofficial/less popular termux packages"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@termux-user-repository & @clandro"
CLANDRO_PKG_VERSION=1.0.1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/apt/sources.list.d
	echo "deb https://tur.kcubeterm.com tur-packages tur tur-on-device tur-continuous" > $CLANDRO_PREFIX/etc/apt/sources.list.d/tur.list
	## tur gpg key
	mkdir -p $CLANDRO_PREFIX/etc/apt/trusted.gpg.d
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/tur.gpg $CLANDRO_PREFIX/etc/apt/trusted.gpg.d/
}

clandro_step_create_debscripts() {
	[ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ] && return 0
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}
