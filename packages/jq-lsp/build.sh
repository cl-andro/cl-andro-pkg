CLANDRO_PKG_HOMEPAGE=https://github.com/wader/jq-lsp
CLANDRO_PKG_DESCRIPTION="jq language server"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.17"
CLANDRO_PKG_SRCURL=https://github.com/wader/jq-lsp/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=899cd2dcd4838d21bab1d84f687cb4a907e0fce7702990dac342b9b6fd88b5a2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR

	cd $CLANDRO_PKG_SRCDIR

	go build -o jq-lsp
}

clandro_step_make_install() {
	cd $CLANDRO_PKG_SRCDIR

	install -Dm700 -t $CLANDRO_PREFIX/bin ./jq-lsp
}
