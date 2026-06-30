CLANDRO_PKG_HOMEPAGE=https://github.com/Depau/ttyc
CLANDRO_PKG_DESCRIPTION="ttyd protocol client"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/Depau/ttyc/archive/refs/tags/ttyc-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=375e2b27335ed3db13aee6d4525548148b8579cdbe34ed4d971d4e3cdff0f173
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -v ./cmd/ttyc
	cd $CLANDRO_PKG_SRCDIR/cmd/ttyc
	go build -o ttyc
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin cmd/ttyc/ttyc
}
