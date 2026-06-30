CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/diskus
CLANDRO_PKG_DESCRIPTION="A minimal, fast alternative to 'du -sh'"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.0"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/diskus/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=c4c9e4cd3cda25f55172130e3d6a58b389f0113fcefa96c73e4c80565547d1bf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
