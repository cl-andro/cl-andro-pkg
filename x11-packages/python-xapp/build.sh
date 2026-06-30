CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/python3-xapp
CLANDRO_PKG_DESCRIPTION="XApp library Python bindings"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/python3-xapp/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=2078766e2553eea0ff2ee598212d4883a226df63d014d060756c6274db024823
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="python, xapp"
CLANDRO_PKG_BREAKS="python3-xapp"
CLANDRO_PKG_REPLACES="python3-xapp"
CLANDRO_PKG_CONFLICTS="python3-xapp"

clandro_step_configure() {
	clandro_setup_meson
	export PYTHON_SITELIB="$CLANDRO_PYTHON_HOME/site-packages"
	$CLANDRO_MESON setup "$CLANDRO_PKG_BUILDDIR" "$CLANDRO_PKG_SRCDIR" \
		-Dlocaledir="$CLANDRO_PREFIX"/share/locale \
		-Dpython.purelibdir="$PYTHON_SITELIB"
}
