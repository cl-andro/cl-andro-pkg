CLANDRO_PKG_HOMEPAGE=https://www.bittorrent.com/btfs/
CLANDRO_PKG_DESCRIPTION="Decentralized file system integrating with TRON network"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.0
CLANDRO_PKG_SRCURL=https://github.com/TRON-US/go-btfs/archive/refs/tags/btfs-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=27de546a83f2c7655a0dbe2bc12e6a8ca7c05ab52f1246263667396fd374f83e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_CACHEDIR/go

	make build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/cmd/btfs/btfs
}
