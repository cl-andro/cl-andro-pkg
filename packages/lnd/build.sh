CLANDRO_PKG_HOMEPAGE=https://github.com/lightningnetwork/lnd
CLANDRO_PKG_DESCRIPTION="Lightning Network Daemon"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.17.0-beta"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(https://github.com/lightningnetwork/lnd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
                   https://github.com/lightningnetwork/lnd/releases/download/v${CLANDRO_PKG_VERSION}/vendor.tar.gz)
CLANDRO_PKG_SHA256=(9aeb1e37e7ffb8726ac8f34c546455305f50fa1a011669462e567740bde26cec
                   4b465f4b334b3516b1150dfde6be6fa78c53938af6e253a456c234f1799a4512)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="bitcoin"
CLANDRO_PKG_SERVICE_SCRIPT=("lnd" 'exec lnd 2>&1')
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang
	GO111MODULE=on go build -tags linux -v -mod=vendor -ldflags "-X github.com/lightningnetwork/lnd/build.Commit=v$CLANDRO_PKG_VERSION" ./cmd/lnd
	GO111MODULE=on go build -tags linux -v -mod=vendor -ldflags "-X github.com/lightningnetwork/lnd/build.Commit=v$CLANDRO_PKG_VERSION" ./cmd/lncli
}

clandro_step_make_install() {
	install -Dm700 lnd lncli "$CLANDRO_PREFIX"/bin/
}
