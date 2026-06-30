CLANDRO_PKG_HOMEPAGE=https://gegl.org/babl/
CLANDRO_PKG_DESCRIPTION="Dynamic pixel format translation library"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.126"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/babl/-/archive/BABL_${CLANDRO_PKG_VERSION//./_}/babl-BABL_${CLANDRO_PKG_VERSION//./_}.tar.gz
CLANDRO_PKG_SHA256=5619fb88d57040e1bf0e1d66385fb463f524f1591cf0fe8400efcd3be8bce287
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="littlecms"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_BREAKS="babl-dev"
CLANDRO_PKG_REPLACES="babl-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-gir=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	cat <<- EOF > "$CLANDRO_PKG_SRCDIR/git-version.h"
	#ifndef BABL_GIT_VERSION
	#define BABL_GIT_VERSION "$CLANDRO_PKG_VERSION termux"
	#endif
	EOF
}
