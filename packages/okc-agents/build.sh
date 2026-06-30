CLANDRO_PKG_HOMEPAGE=https://github.com/DDoSolitary/okc-agents
CLANDRO_PKG_DESCRIPTION="OpenKeychain agents for GnuPG and OpenSSH"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/DDoSolitary/okc-agents/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9292044aac8d20723e4c9a157e1a4968ef0266d75643411ebc34f75d9d76af7e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
