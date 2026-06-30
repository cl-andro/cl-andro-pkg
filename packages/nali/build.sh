CLANDRO_PKG_HOMEPAGE=https://github.com/zu1k/nali
CLANDRO_PKG_DESCRIPTION="An offline tool for querying IP geographic information and CDN provider"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/zu1k/nali/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8918e4c1c720dad1590a42fa04c5fea1ec862148127206e716daa16c1ce3561c
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin nali
}
