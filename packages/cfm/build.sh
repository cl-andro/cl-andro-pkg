CLANDRO_PKG_HOMEPAGE=https://github.com/0l1v3rr/cli-file-manager
CLANDRO_PKG_DESCRIPTION="A basic file manager that runs inside a terminal, designed for Linux. It's fully responsive and incredibly fast."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/0l1v3rr/cli-file-manager/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1a955225a72e822b9a1a1e13edbb460770e7102206050560919de4420cb1474a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	make build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/cfm
}
