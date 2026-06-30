CLANDRO_PKG_HOMEPAGE=https://github.com/docker/compose
CLANDRO_PKG_DESCRIPTION="Compose is a tool for defining and running multi-container Docker applications."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.1.3"
CLANDRO_PKG_SRCURL="https://github.com/docker/compose/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=19c7219c97390473bb96530153e64fce98d4b05ecf6f73016e564201d99512e7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS=docker

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR
	cd $CLANDRO_PKG_SRCDIR
	mkdir bin/
	if ! [ -z "$GOOS" ];then export GOOS=android;fi
	go build -o bin/docker-compose -ldflags="-s -w -X github.com/docker/compose/v2/internal.Version=${CLANDRO_PKG_VERSION}" ./cmd
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/libexec/docker/cli-plugins "${CLANDRO_PKG_SRCDIR}"/bin/docker-compose
}
