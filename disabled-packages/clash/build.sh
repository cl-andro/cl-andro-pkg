CLANDRO_PKG_HOMEPAGE=https://github.com/Dreamacro/clash
CLANDRO_PKG_DESCRIPTION="A rule-based tunnel in Go"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.18.0"
CLANDRO_PKG_SRCURL="https://github.com/Dreamacro/clash/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=139794f50d3d94f438bab31a993cf25d7cbdf8ca8e034f3071e0dd0014069692
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"

	GOBUILD=CGO_ENABLED=0 \
		go build \
			-trimpath \
			-ldflags "-X 'github.com/Dreamacro/clash/constant.Version=${CLANDRO_PKG_VERSION}'
								-X 'github.com/Dreamacro/clash/constant.BuildTime=$(date -u)'
								-w -s -buildid='" \
			-o "clash.bin" \
			main.go
}

clandro_step_make_install() {
	mv ./clash.bin "${CLANDRO_PREFIX}/bin/clash"
}
