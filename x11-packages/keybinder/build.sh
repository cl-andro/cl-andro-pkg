CLANDRO_PKG_HOMEPAGE=https://github.com/kupferlauncher/keybinder
CLANDRO_PKG_DESCRIPTION="A library for registering global keyboard shortcuts"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.3.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/kupferlauncher/keybinder/releases/download/keybinder-3.0-v${CLANDRO_PKG_VERSION}/keybinder-3.0-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e6e3de4e1f3b201814a956ab8f16dfc8a262db1937ff1eee4d855365398c6020
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxext, libxrender, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
