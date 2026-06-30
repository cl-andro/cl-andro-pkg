CLANDRO_PKG_HOMEPAGE=https://github.com/msoap/shell2http
CLANDRO_PKG_DESCRIPTION="Executing shell commands via HTTP server"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="1.17.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/msoap/shell2http/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=17fab67e34e767accfbc59ab504971c704f54d79b57a023e6b5efa5556994624
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/msoap/"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/msoap/shell2http"
	cd "${GOPATH}/src/github.com/msoap/shell2http"
	go get -d -v
	go build -ldflags "-X 'main.version=$CLANDRO_PKG_VERSION'"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$GOPATH"/src/github.com/msoap/shell2http/shell2http
}
