CLANDRO_PKG_HOMEPAGE=https://www.w3.org/TR/WOFF2/
CLANDRO_PKG_DESCRIPTION="font compression reference code"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
# Revdep rebuild may be required with every version bump.
CLANDRO_PKG_VERSION=1.0.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/google/woff2/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=add272bb09e6384a4833ffca4896350fdb16e0ca22df68c0384773c67a175594
# SOVERSION is equal to VERSION. Do not enable auto-update.
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="brotli, libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin woff2_{compress,decompress,info}
}
