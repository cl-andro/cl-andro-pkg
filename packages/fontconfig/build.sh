CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
CLANDRO_PKG_DESCRIPTION="Library for configuring and customizing font access"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.17.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/$CLANDRO_PKG_VERSION/fontconfig-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=82e73b26adad651b236e5f5d4b3074daf8ff0910188808496326bd3449e5261d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, libexpat, ttf-dejavu"
CLANDRO_PKG_BREAKS="fontconfig-dev"
CLANDRO_PKG_REPLACES="fontconfig-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libxml2=no
--enable-iconv=no
--disable-docs
--with-default-fonts=/system/fonts
--with-add-fonts=$CLANDRO_PREFIX/share/fonts
"

clandro_step_pre_configure() {
	autoreconf -fi
}
