CLANDRO_PKG_HOMEPAGE=https://github.com/cloudflare/cloudflared
CLANDRO_PKG_DESCRIPTION="A tunneling daemon that proxies traffic from the Cloudflare network to your origins"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2026.3.0"
CLANDRO_PKG_SRCURL=https://github.com/cloudflare/cloudflared/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1c9e88653f091d3085975e50c2cf7308923c88ed5c82afe7fb98938d3f9c93ad
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	local _DATE=$(date -u '+%Y.%m.%d-%H:%M UTC')
	go build -v -ldflags "-X \"main.Version=$CLANDRO_PKG_VERSION\" -X \"main.BuildTime=$_DATE\"" \
		./cmd/cloudflared
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin cloudflared
}
