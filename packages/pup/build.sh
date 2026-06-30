CLANDRO_PKG_HOMEPAGE=https://github.com/ericchiang/pup
CLANDRO_PKG_DESCRIPTION="command line tool for processing HTML"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION=0.4.0
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/ericchiang/pup/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0d546ab78588e07e1601007772d83795495aa329b19bd1c3cde589ddb1c538b0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	go mod init github.com/ericchiang/pup || :
	go mod tidy
	go mod vendor

	go build
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin pup
	install -Dm644 -t "$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME" README*
}
