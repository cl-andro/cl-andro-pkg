CLANDRO_PKG_HOMEPAGE=http://www.nongnu.org/oath-toolkit/
CLANDRO_PKG_DESCRIPTION="One-time password components"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.12"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://download.savannah.nongnu.org/releases/oath-toolkit/oath-toolkit-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=cafdf739b1ec4b276441c6aedae6411434bbd870071f66154b909cc6e2d9e8ba
CLANDRO_PKG_DEPENDS="libxml2, xmlsec"
CLANDRO_PKG_BREAKS="oathtool-dev"
CLANDRO_PKG_REPLACES="oathtool-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-pam"

clandro_step_post_configure() {
	# Fix out-of-tree build
	local _gdoc="./libpskc/man/gdoc"
	if [ ! -e "${_gdoc}" ]; then
		ln -sf "$CLANDRO_PKG_SRCDIR/libpskc/man/gdoc" "${_gdoc}"
	fi

	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libpskc/libtool
}
