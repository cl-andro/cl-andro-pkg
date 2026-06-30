CLANDRO_PKG_HOMEPAGE=https://www.bittorrent.com/btfs/
CLANDRO_PKG_DESCRIPTION="Decentralized file system integrating with TRON network and Bittorrent network"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.1.0"
CLANDRO_PKG_SRCURL=https://github.com/bittorrent/go-btfs/archive/refs/tags/btfs-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=64ccbe66ffe6e0a7b789eda54a9ba0be233848c6af1989c71d0b89e92253d5d7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="btfs"
CLANDRO_PKG_REPLACES="btfs"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	make build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/cmd/btfs/btfs
	ln -sfT btfs $CLANDRO_PREFIX/bin/btfs2
}
