CLANDRO_PKG_HOMEPAGE="https://github.com/itchyny/bed"
CLANDRO_PKG_DESCRIPTION="Binary editor written in GO"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.8"
CLANDRO_PKG_SRCURL="https://github.com/itchyny/bed/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=2515fd65c718f7aaa549bf9a98cf514102d2ea5f3b1c0437bbcf8bd26fae4d0a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true


clandro_step_make() {
	clandro_setup_golang
	go build -ldflags="-s -w" -o bed ./cmd/bed
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bed
}
