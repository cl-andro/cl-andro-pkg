CLANDRO_PKG_HOMEPAGE=https://github.com/n0-computer/sendme
CLANDRO_PKG_DESCRIPTION="A tool to send files and directories, based on iroh"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="
LICENSE-APACHE
LICENSE-MIT
"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.34.0"
CLANDRO_PKG_SRCURL="https://github.com/n0-computer/sendme/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=5231ce3bf8636d0aa98dc612e0288ca3083d55d2983ae666d98762a9af926709
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
