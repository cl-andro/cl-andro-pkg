CLANDRO_PKG_HOMEPAGE=https://zeronet.io/
CLANDRO_PKG_DESCRIPTION="Decentralized websites using Bitcoin crypto and BitTorrent network"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.1
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL=https://github.com/HelloZeroNet/ZeroNet/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=78a27e1687d8e3699a854b77b516c95b30a8ba667f7ebbef0aabf7ec6ec7272d
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_CONFFILES="etc/zeronet.conf"
CLANDRO_PKG_DEPENDS="bash, clang, make, openssl-tool, pkg-config, python"
CLANDRO_PKG_RECOMMENDS="tor"

clandro_step_make_install() {
	# ZeroNet sources.
	mkdir -p "$CLANDRO_PREFIX"/opt
	rm -rf "$CLANDRO_PREFIX"/opt/zeronet
	cp -a "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PREFIX"/opt/zeronet

	# Installer.
	install -Dm700 "$CLANDRO_PKG_BUILDER_DIR"/installer.sh \
		"$CLANDRO_PREFIX"/opt/zeronet/installer.sh
	sed -i "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$CLANDRO_PREFIX"/opt/zeronet/installer.sh

	# Wrapper.
	install -Dm700 "$CLANDRO_PKG_BUILDER_DIR"/zeronet.sh \
		"$CLANDRO_PREFIX"/bin/zeronet
	sed -i "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$CLANDRO_PREFIX"/bin/zeronet

	# Configuration file.
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/zeronet.conf \
		"$CLANDRO_PREFIX"/etc/zeronet.conf
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/lib/zeronet
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/log/zeronet
}

clandro_step_create_debscripts() {
	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "bash $CLANDRO_PREFIX/opt/zeronet/installer.sh"
	} > ./postinst
	chmod 755 ./postinst

	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "[ \$1 != remove ] && exit 0"
		echo "echo \"Removing ZeroNet files...\""
		echo "rm -rf $CLANDRO_PREFIX/opt/zeronet"
		echo "rm -rf $CLANDRO_PREFIX/var/lib/zeronet"
		echo "rm -rf $CLANDRO_PREFIX/var/log/zeronet"
		echo "exit 0"
	} > ./postrm
	chmod 755 ./postrm
}
