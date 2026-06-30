CLANDRO_PKG_HOMEPAGE=https://github.com/natesales/q
CLANDRO_PKG_DESCRIPTION="A tiny command line DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="kay9925@outlook.com"
CLANDRO_PKG_VERSION="0.19.12"
CLANDRO_PKG_SRCURL="https://github.com/natesales/q/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1f56ebfb93fd380dee734cca9227149de2491c49db7b2c0f21019fd463081e4c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	local _builtAt=$(date +'%FT%T%Z')

	local ldflags="\
	-w -s \
	-X 'main.version=${CLANDRO_PKG_VERSION}' \
	-X 'main.commit=$(git log -1 --format=%H)' \
	-X 'main.date=${_builtAt}' \
	"

	export CGO_ENABLED=1

	go build -o "${CLANDRO_PKG_NAME}" -ldflags="$ldflags"
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_NAME} ${CLANDRO_PREFIX}/bin/q
}
