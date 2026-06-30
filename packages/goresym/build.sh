CLANDRO_PKG_HOMEPAGE=https://github.com/mandiant/GoReSym
CLANDRO_PKG_DESCRIPTION="Go symbol recovery tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3"
CLANDRO_PKG_SRCURL=https://github.com/mandiant/goresym/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e0afe3faaf824460b611a1ef6e93015341cfea999a6237516c15b59f8936d3f0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	go build -o goresym
}

clandro_step_make_install() {
	install -Dm755 goresym $CLANDRO_PREFIX/bin/goresym
}
