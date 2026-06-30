CLANDRO_PKG_HOMEPAGE=https://launchpad.net/pastebinit
CLANDRO_PKG_DESCRIPTION="Command-line pastebin client"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/felixonmars/pastebinit/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=30850b9dc6b3e9105321cee159d491891b3d3c03180440edffa296c7e1ac0c41
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_make_install() {
	cp pastebinit $CLANDRO_PREFIX/bin/
	xsltproc -''-nonet /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl pastebinit.xml
	cp pastebinit.1 $CLANDRO_PREFIX/share/man/man1/

	rm -Rf $CLANDRO_PREFIX/etc/pastebin.d
	mv pastebin.d $CLANDRO_PREFIX/etc
}
