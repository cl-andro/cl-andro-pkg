CLANDRO_PKG_HOMEPAGE=https://github.com/tatsuhiro-t/wslay
CLANDRO_PKG_DESCRIPTION="WebSocket library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/tatsuhiro-t/wslay/releases/download/release-$CLANDRO_PKG_VERSION/wslay-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=6a3e2ceba52424b14521a7469a35bfd781b018ca93c300b71df3618273af6ed9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PROVIDES="wslay"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_massage() {
	find lib -name '*.la' -delete
}
