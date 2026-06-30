CLANDRO_PKG_HOMEPAGE="https://libproxy.github.io/"
CLANDRO_PKG_DESCRIPTION="Automatic proxy configuration management library"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.12"
CLANDRO_PKG_SRCURL="https://github.com/libproxy/libproxy/archive/refs/tags/${CLANDRO_PKG_VERSION}/libproxy-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="a1fa55991998b80a567450a9e84382421a7176a84446c95caaa8b72cf09fa86f"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="curl, duktape, glib"
CLANDRO_PKG_BUILD_DEPENDS="gsettings-desktop-schemas, g-ir-scanner"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dvapi=false
-Ddocs=false
-Dintrospection=false
"
