CLANDRO_PKG_HOMEPAGE=https://wakatime.com/plugins/
CLANDRO_PKG_DESCRIPTION="Command line interface used by all WakaTime text editor plugins"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.13.0"
CLANDRO_PKG_SRCURL=https://github.com/wakatime/wakatime-cli/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2c5e020f3578dc6abdc46c562acf68408dfdf4f06e897c1c576044909599d6cb
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	rm -f Makefile
	clandro_setup_golang

	local _REPO=github.com/wakatime/wakatime-cli
	local _COMMIT=$(git ls-remote https://github.com/wakatime/wakatime-cli refs/tags/v$CLANDRO_PKG_VERSION | head -c 7)
	local _DATE=$(date -u '+%Y-%m-%dT%H:%M:%S %Z')
	go build -o wakatime-cli -ldflags="-s -w -X '${_REPO}/pkg/version.BuildDate=${_DATE}' -X '${_REPO}/pkg/version.Commit=${_COMMIT}' -X '${_REPO}/pkg/version.Version=${CLANDRO_PKG_VERSION}' -X '${_REPO}/pkg/version.OS=android' -X '${_REPO}/pkg/version.Arch=$(go env GOARCH)'"
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin ${CLANDRO_PKG_SRCDIR}/wakatime-cli
}
