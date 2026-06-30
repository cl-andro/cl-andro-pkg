CLANDRO_PKG_HOMEPAGE=https://www.storj.io/integrations/uplink-cli
CLANDRO_PKG_DESCRIPTION="Storj DCS Uplink CLI"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.153.2"
CLANDRO_PKG_SRCURL=https://github.com/storj/storj/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f19c095f1ab264073c7f68e97594ef1314aae560d237db012bb4786f4b5c94b7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build ./cmd/uplink
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin uplink
}
