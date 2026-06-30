CLANDRO_PKG_HOMEPAGE=https://github.com/libxmp/libxmp
CLANDRO_PKG_DESCRIPTION="Extended Module Player C Library that renders tracker and module music (MOD, S3M, IT, XM etc.)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.7.0"
CLANDRO_PKG_SRCURL="https://github.com/libxmp/libxmp/releases/download/libxmp-${CLANDRO_PKG_VERSION}/libxmp-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b6251de1859352c6988752563d60983cb8aa9fd7dfe9f81b8bc6688da47f3464
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_FORCE_CMAKE=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED=ON
-DBUILD_STATIC=ON
-DLIBM_REQUIRED=ON
-DLIBM_LIBRARY=m
"

clandro_step_pre_configure() {
	# Extract license from README and save it to a new LICENSE file
	sed -n '/^LICENSE$/,/^THE SOFTWARE\.$/p' README > "$CLANDRO_PKG_SRCDIR/LICENSE"
}
