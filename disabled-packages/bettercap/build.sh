# root-packages
CLANDRO_PKG_HOMEPAGE=https://www.bettercap.org
CLANDRO_PKG_DESCRIPTION="The Swiss Army knife for 802.11, BLE and Ethernet networks reconnaissance and MITM attacks"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.32.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/bettercap/bettercap/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ea28d4d533776a328a54723a74101d1720016ffe7d434bf1d7ab222adb397ac6
CLANDRO_PKG_DEPENDS="libpcap, libusb, libnetfilter-queue"

clandro_step_configure() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR	
	export CGO_CFLAGS="-I$CLANDRO_PREFIX/include"

	mkdir -p "$GOPATH"/src/github.com/bettercap/
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/bettercap/bettercap
	go get github.com/bettercap/recording
}

clandro_step_make() {
	cd src/github.com/bettercap/bettercap
	make build
}

clandro_step_make_install() {
	cd src/github.com/bettercap/bettercap
	make install
}
