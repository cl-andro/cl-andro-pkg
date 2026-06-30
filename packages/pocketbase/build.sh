CLANDRO_PKG_HOMEPAGE=https://github.com/pocketbase/pocketbase
CLANDRO_PKG_DESCRIPTION="An open source Go backend"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.38.0"
CLANDRO_PKG_SRCURL="https://github.com/pocketbase/pocketbase/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=de20714bc234c86857f8a7fd15240cd027e221450008d49a9cc4d58185e635e2
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"

	cd "$CLANDRO_PKG_SRCDIR/examples/base"

	export GOBUILD=CGO_ENABLED=0

	go build \
		-trimpath \
		-o "pocketbase.bin" \
		main.go
}

clandro_step_make_install() {
	install -m700 examples/base/pocketbase.bin "${CLANDRO_PREFIX}"/bin/pocketbase
}
