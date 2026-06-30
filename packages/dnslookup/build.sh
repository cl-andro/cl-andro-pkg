CLANDRO_PKG_HOMEPAGE=https://github.com/ameshkov/dnslookup
CLANDRO_PKG_DESCRIPTION="Simple command line utility to make DNS lookups. Supports all known DNS protocols: plain DNS, DoH, DoT, DoQ, DNSCrypt."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="CHIZI-0618 <kay9925@outlook.com>"
CLANDRO_PKG_VERSION="1.11.2"
CLANDRO_PKG_SRCURL="https://github.com/ameshkov/dnslookup/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0f4b74a4ac8c967b089eebc62fbf65334e76d42da4c4524e8182bb8400aa119d
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export CGO_ENABLED=1

	go build -ldflags "-X main.VersionString=v${CLANDRO_PKG_VERSION}" -o "${CLANDRO_PKG_NAME}"
}

clandro_step_make_install() {
	install -Dm700 "${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}/bin"
}
