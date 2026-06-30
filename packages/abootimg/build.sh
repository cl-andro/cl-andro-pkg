CLANDRO_PKG_HOMEPAGE=https://gitlab.com/ajs124/abootimg
CLANDRO_PKG_DESCRIPTION="Pack or unpack android boot images"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://gitlab.com/ajs124/abootimg/-/archive/v${CLANDRO_PKG_VERSION}/abootimg-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1dde5cadb8a14fccc677e5422d32c969a49c705daa03ce9b69af941247ff7cde
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="util-linux, libblkid"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source () {
	echo "#define VERSION_STR \"$CLANDRO_PKG_VERSION\"" > $CLANDRO_PKG_SRCDIR/version.h
	touch -d "next hour" $CLANDRO_PKG_SRCDIR/version.h
}
