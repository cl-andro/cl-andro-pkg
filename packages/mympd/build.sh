CLANDRO_PKG_HOMEPAGE=https://jcorporation.github.io/myMPD/
CLANDRO_PKG_DESCRIPTION="A standalone and lightweight web-based MPD client"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="25.0.2"
CLANDRO_PKG_SRCURL=https://github.com/jcorporation/myMPD/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5e482074eb36a7fc6047ecd5bc1cfa707850a4ae936c36bbf0faebd6ed00cfef
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libflac, libid3tag, lua54, openssl, pcre2, resolv-conf"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DMATH_LIB=m
-DMYMPD_STARTUP_SCRIPT=OFF
"
