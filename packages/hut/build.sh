CLANDRO_PKG_HOMEPAGE=https://git.sr.ht/~xenrox/hut
CLANDRO_PKG_DESCRIPTION="A CLI tool for sr.ht"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.0"
CLANDRO_PKG_SRCURL=https://git.sr.ht/~xenrox/hut/refs/download/v${CLANDRO_PKG_VERSION}/hut-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b7ebc3618603df2e72635cdb2358e5ca2db2e92ce257fa78a72e8de7b25e9ae7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}
