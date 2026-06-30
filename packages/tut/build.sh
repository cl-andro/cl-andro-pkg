CLANDRO_PKG_HOMEPAGE=https://github.com/RasmusLindroth/tut
CLANDRO_PKG_DESCRIPTION="A TUI for Mastodon with vim inspired keys"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/RasmusLindroth/tut/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=afa8c49036461a36c091d83ef51f9a3bbd938ee78f817c6467175699a989b863
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin tut
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME config.example.toml
}
