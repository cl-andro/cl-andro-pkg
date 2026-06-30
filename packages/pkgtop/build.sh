CLANDRO_PKG_HOMEPAGE=https://github.com/orhun/pkgtop
CLANDRO_PKG_DESCRIPTION="Interactive package manager and resource monitor"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.1"
CLANDRO_PKG_SRCURL=https://github.com/orhun/pkgtop/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3d8f1cd812fd2243fbf749ab03201bb86b9967cefd5d58cea456cdfcccfd416e
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o pkgtop ./cmd
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin pkgtop
}
