CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="Building tools required by LXQt project"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="BSD-3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.13.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-build-tools/releases/download/${CLANDRO_PKG_VERSION}/lxqt-build-tools-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=fd3c199d0d7c61f23040a45ead57cc9a4f888af5995371f6b0ce1fa902eb59ce
CLANDRO_PKG_DEPENDS="cmake, libc++, qt5-qtbase"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
# Prevent updating to latest lxqt2-build-tools
CLANDRO_PKG_AUTO_UPDATE=false
