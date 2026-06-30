# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://hostap.epitest.fi/wpa_supplicant
CLANDRO_PKG_DESCRIPTION="Utility providing key negotiation for WPA wireless networks"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://w1.fi/releases/wpa_supplicant-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_DEPENDS="openssl, readline, libnl"
CLANDRO_PKG_SHA256=912ea06f74e30a8e36fbb68064d6cdff218d8d591db0fc5d75dee6c81ac7fc0a
CLANDRO_PKG_EXTRA_MAKE_ARGS="-C wpa_supplicant"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_configure() {
	cp wpa_supplicant/defconfig wpa_supplicant/.config
	export EXTRA_CFLAGS=$CPPFLAGS
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/man/{man5,man8}
	install -m600 wpa_supplicant/doc/docbook/wpa_supplicant.conf.5 $CLANDRO_PREFIX/share/man/man5/
	install -m600 wpa_supplicant/doc/docbook/{wpa_cli,wpa_supplicant}.8 $CLANDRO_PREFIX/share/man/man8/
}
