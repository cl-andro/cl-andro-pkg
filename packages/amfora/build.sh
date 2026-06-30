CLANDRO_PKG_HOMEPAGE=https://github.com/makew0rld/amfora
CLANDRO_PKG_DESCRIPTION="Aims to be the best looking Gemini client"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.11.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/makew0rld/amfora/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=76ae120bdae9a1882acbb2b07a873a52e40265b3ef4c8291de0934c1e9b5982c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX VERSION=$CLANDRO_PKG_VERSION"

clandro_step_pre_configure() {
	clandro_setup_golang
	sed -i 's|CGO_ENABLED=0|CGO_ENABLED=1|g' Makefile

	go mod init || :
	go mod tidy
}
