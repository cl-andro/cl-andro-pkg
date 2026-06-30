CLANDRO_PKG_HOMEPAGE=https://restic.net/
CLANDRO_PKG_DESCRIPTION="Restic's REST backend API server"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/restic/rest-server/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8b3f91d561819ba9bce454505958fcca6d61ecd12e10086954ebfc92ba163ba4
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	_GOARCH="${GOARCH}"
	unset GOOS GOARCH
	go run build.go \
		--enable-cgo \
		--goos android \
		--goarch "${_GOARCH}"
}

clandro_step_make_install() {
	install -Dm755 rest-server "${CLANDRO_PREFIX}/bin/rest-server"
}
