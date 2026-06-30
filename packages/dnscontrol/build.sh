CLANDRO_PKG_HOMEPAGE=https://github.com/StackExchange/dnscontrol
CLANDRO_PKG_DESCRIPTION="Infrastructure as code for DNS!"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Izumi Sena Sora <info@unordinary.eu.org>"
CLANDRO_PKG_VERSION="4.37.1"
CLANDRO_PKG_SRCURL="https://github.com/StackExchange/dnscontrol/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=144068a45d50cd0685bbb947384b55a6255c13960649c5d0c5278532d69df423
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	go build -o "${CLANDRO_PKG_NAME}"
}

clandro_step_make_install() {
	install -Dm700 "${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}/bin"
}
