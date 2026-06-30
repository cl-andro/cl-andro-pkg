CLANDRO_PKG_HOMEPAGE=https://www.getdnote.com/
CLANDRO_PKG_DESCRIPTION="This package contains the Dnote server. It comprises of the web interface, the web API, and the background jobs."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Ravener <ravener.anime@gmail.com>"
CLANDRO_PKG_VERSION="3.0.0"
CLANDRO_PKG_SRCURL="https://github.com/dnote/dnote/archive/refs/tags/server-v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=5a6beef7e8902386443407e020e2c4b54dec9e5e285224646c39020deebb5880
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="server-v\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SUGGESTS="postgresql"

clandro_step_pre_configure() {
	clandro_setup_nodejs
	clandro_setup_golang

	go mod download

	# build assets for dnote-server:
	cd "$CLANDRO_PKG_SRCDIR/pkg/server/assets"
	npm i
	./js/build.sh
	./styles/build.sh
}

clandro_step_make() {
	cd "$CLANDRO_PKG_SRCDIR"

	# build binary
	moduleName="github.com/dnote/dnote"
	ldflags="-X '$moduleName/pkg/server/buildinfo.CSSFiles=main.css' -X '$moduleName/pkg/server/buildinfo.JSFiles=main.js' -X '$moduleName/pkg/server/buildinfo.Version=$CLANDRO_PKG_VERSION' -X '$moduleName/pkg/server/buildinfo.Standalone=true'"

	go build -o dnote-server -ldflags "$ldflags" pkg/server/main.go
}

clandro_step_make_install() {
	install -Dm700 $CLANDRO_PKG_SRCDIR/dnote-server $CLANDRO_PREFIX/bin/dnote-server
}
