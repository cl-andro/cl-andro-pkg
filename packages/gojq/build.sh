CLANDRO_PKG_HOMEPAGE=https://github.com/itchyny/gojq
CLANDRO_PKG_DESCRIPTION="Pure Go implementation of jq"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.19"
CLANDRO_PKG_SRCURL=https://github.com/itchyny/gojq/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=d6c6ecf8b7d9ed892216aee61101e8bc45359dc63d5ba3ab596922c4ea11e1ab
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	go mod tidy
	go build -o gojq ./cmd/gojq
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" gojq
}
