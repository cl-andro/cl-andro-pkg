CLANDRO_PKG_HOMEPAGE=https://github.com/bluenviron/mediamtx
CLANDRO_PKG_DESCRIPTION="Ready-to-use SRT / WebRTC / RTSP / RTMP / LL-HLS media server and media proxy"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.18.1"
CLANDRO_PKG_SRCURL=https://github.com/bluenviron/mediamtx/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=69bcff6eec0fa85fbf8aa36d2e91c4df94b288e0957e0a03791312c26de6211f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	clandro_setup_golang
	go generate ./...
}

clandro_step_make() {
	clandro_setup_golang
	echo "v${CLANDRO_PKG_VERSION}" > "${CLANDRO_PKG_SRCDIR}"/internal/core/VERSION
	export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"

	# -checklinkname=0 for https://github.com/wlynxg/anet?tab=readme-ov-file#how-to-build-with-go-1230-or-later
	go build -ldflags='-checklinkname=0 -s -w -linkmode=external'
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin mediamtx
	install -Dm600 -t "${CLANDRO_PREFIX}"/etc/mediamtx mediamtx.yml
}
