CLANDRO_PKG_HOMEPAGE=https://ipfs.io/
CLANDRO_PKG_DESCRIPTION="A peer-to-peer hypermedia distribution protocol"
CLANDRO_PKG_LICENSE="MIT, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE-APACHE, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.41.0"
CLANDRO_PKG_SRCURL="https://github.com/ipfs/kubo/releases/download/v${CLANDRO_PKG_VERSION}/kubo-source.tar.gz"
CLANDRO_PKG_SHA256=d20dce2c72f5ee99e2604fa1331ae493cec26c9a3a214de6ec236383dd26951b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SUGGESTS="clandro-services"
CLANDRO_PKG_SERVICE_SCRIPT=("ipfs" "[ ! -d \"${CLANDRO_ANDROID_HOME}/.ipfs\" ] && ipfs init --empty-repo 2>&1 && ipfs config --json Swarm.EnableRelayHop false 2>&1 && ipfs config --json Swarm.EnableAutoRelay true 2>&1; exec ipfs daemon --enable-namesys-pubsub 2>&1")
CLANDRO_PKG_CONFLICTS="ipfs"
CLANDRO_PKG_REPLACES="ipfs"
CLANDRO_PKG_PROVIDES="ipfs"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=${CLANDRO_PKG_BUILDDIR}

	mkdir -p "${GOPATH}/src/github.com/ipfs"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/ipfs/kubo"
	cd "${GOPATH}/src/github.com/ipfs/kubo"

	# TODO: remove this once the upstream package is updated to suport go 1.26
	go mod edit -replace github.com/cockroachdb/swiss=github.com/cockroachdb/swiss@b0f6560
	go mod tidy
	go mod vendor
	make build

	# Fix folders without write permissions preventing which fails repeating builds:
	cd "$CLANDRO_PKG_BUILDDIR"
	find . -type d -exec chmod u+w {} \;
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "${CLANDRO_PKG_BUILDDIR}/src/github.com/ipfs/kubo/cmd/ipfs/ipfs"
}
