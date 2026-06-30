CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Common scripts and macros to develop with MATE"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_SRCURL=https://github.com/mate-desktop/mate-common/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7100ecd60a9b5f398b9c3508eb17bca657bb748a74fc9f277b1e5ba1e022b701
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	autoreconf -fi
}
