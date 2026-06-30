CLANDRO_PKG_HOMEPAGE=https://github.com/anomalyco/clandro-pkg
CLANDRO_PKG_DESCRIPTION="Control Android apps via the Cluster Bridge (Shizuku)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@anomalyco"
CLANDRO_PKG_VERSION="1.0.0"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_make_install() {
	install -Dm755 "$CLANDRO_PKG_BUILDER_DIR/clusterctl" "$CLANDRO_PREFIX/bin/clusterctl"
}
