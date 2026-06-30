CLANDRO_PKG_HOMEPAGE=https://github.com/kubecolor/kubecolor
CLANDRO_PKG_DESCRIPTION="Colorize your kubectl output"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Kalle Fagerberg @applejag"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_SRCURL=https://github.com/kubecolor/kubecolor/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=99b2126c4d33664220ee8270def853d668ebdb1418b1eeaf93b1ab7d8799561c
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kubectl"

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	go build -o kubecolor -ldflags "-X main.Version=v${CLANDRO_PKG_VERSION}"
}

clandro_step_make_install() {
	install -Dm700 kubecolor "$CLANDRO_PREFIX/bin"
}
