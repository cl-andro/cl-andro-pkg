CLANDRO_PKG_HOMEPAGE=https://termshark.io
CLANDRO_PKG_DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=git+https://github.com/gcla/termshark
CLANDRO_PKG_DEPENDS="tshark"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	export GO111MODULE=on

	cd $CLANDRO_PKG_SRCDIR
	go install ./...
}

clandro_step_make_install() {
	install -Dm700 bin/android_${GOARCH}/termshark $CLANDRO_PREFIX/bin/termshark
}
