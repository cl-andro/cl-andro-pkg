CLANDRO_PKG_HOMEPAGE=https://www.wireguard.com
CLANDRO_PKG_DESCRIPTION="Tools for the WireGuard secure network tunnel"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.20210914
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=97ff31489217bb265b7ae850d3d0f335ab07d2652ba1feec88b734bc96bd05ac
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS=" -C src WITH_BASHCOMPLETION=yes WITH_WGQUICK=no WITH_SYSTEMDUNITS=no"

clandro_step_post_make_install() {
	cd src/wg-quick
	$CC $CFLAGS $LDFLAGS -DWG_CONFIG_SEARCH_PATHS="\"$CLANDRO_ANDROID_HOME/.wireguard $CLANDRO_PREFIX/etc/wireguard /data/misc/wireguard /data/data/com.wireguard.android/files\"" -o wg-quick android.c
	install -Dm0700 wg-quick $CLANDRO_PREFIX/bin/wg-quick
}
