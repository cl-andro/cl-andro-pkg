CLANDRO_PKG_HOMEPAGE=https://github.com/jstedfast/gmime
CLANDRO_PKG_DESCRIPTION="MIME message parser and creator"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.2.15"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/jstedfast/gmime/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=06662db189ce56782c23c7c4adfebfa512350c2fa9514f0d551df42c7f940076
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libiconv, libidn2, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_BREAKS="libgmime-dev"
CLANDRO_PKG_REPLACES="libgmime-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_iconv_detect_h=yes
--with-libiconv=gnu
--disable-crypto
--enable-vala
"

clandro_step_pre_configure() {
	clandro_setup_gir

	NOCONFIGURE=1 ./autogen.sh

	cp "$CLANDRO_PKG_BUILDER_DIR"/iconv-detect.h ./
}
