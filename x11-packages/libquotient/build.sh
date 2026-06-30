CLANDRO_PKG_HOMEPAGE="https://quotient-im.github.io/libQuotient"
CLANDRO_PKG_DESCRIPTION="A Qt library to write cross-platform clients for Matrix"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.6.1"
CLANDRO_PKG_SRCURL="https://github.com/quotient-im/libQuotient/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ac0fe5df480fa893d3e16da626bf5028c944e9b41f504f6fe0fe49273247d636
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libolm, openssl, qt6-qtbase, qtkeychain"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
