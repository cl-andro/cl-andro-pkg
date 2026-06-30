CLANDRO_PKG_HOMEPAGE=https://github.com/iawia002/lux
CLANDRO_PKG_DESCRIPTION="CLI tool to download videos from various websites"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="0.24.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/iawia002/lux/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=69d4fe58c588cc6957b8682795210cd8154170ac51af83520c6b1334901c6d3d
CLANDRO_PKG_RECOMMENDS="ffmpeg"
CLANDRO_PKG_SUGGESTS="aria2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	mkdir bin
	# https://github.com/iawia002/lux/issues/1340
	# https://github.com/iawia002/lux/blob/348ae97219784a32dd3c4721ad0cbc2584ee7b46/.goreleaser.yml#L10
	go build -o ./bin -trimpath -ldflags "-s -w -X github.com/iawia002/lux/app.version=v${CLANDRO_PKG_VERSION}"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/*
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
}
