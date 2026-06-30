CLANDRO_PKG_HOMEPAGE=https://github.com/facebookincubator/fastmod
CLANDRO_PKG_DESCRIPTION="Regex-based code refactoring utility"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/facebookincubator/fastmod/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b438cc7564ef34d01f27cdd3cd50ee66a9915b9c50939ca021c6bee2e9c1f069
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
