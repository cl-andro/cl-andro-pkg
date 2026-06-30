# Contributor: @medzikuser
CLANDRO_PKG_HOMEPAGE=https://github.com/xxxserxxx/gotop
CLANDRO_PKG_DESCRIPTION="A terminal based graphical activity monitor inspired by gtop and vtop"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2.0"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/xxxserxxx/gotop/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e9d9041903acb6bd3ffe94e0a02e69eea53f1128274da1bfe00fe44331ccceb1
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR

	cd $CLANDRO_PKG_SRCDIR

	go build -o gotop \
		-ldflags "-X main.Version=v${CLANDRO_PKG_VERSION} -X main.BuildDate=$(date +%Y%m%dT%H%M%S)" \
		./cmd/gotop

	install -Dm700 -t $CLANDRO_PREFIX/bin ./gotop
}
