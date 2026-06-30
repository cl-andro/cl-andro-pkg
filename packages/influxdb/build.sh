CLANDRO_PKG_HOMEPAGE=https://www.influxdata.com/
CLANDRO_PKG_DESCRIPTION="An open source time series database with no external dependencies"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
# It cannot be simply updated to the 2.0 series, for which the build system is
# pretty much different from that for 1.x.
_GIT_BRANCH=1.8
CLANDRO_PKG_VERSION=${_GIT_BRANCH}.10
CLANDRO_PKG_REVISION=4
_COMMIT=688e697c51fd5353725da078555adbeff0363d01
CLANDRO_PKG_SRCURL=https://github.com/influxdata/influxdb/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4f53c61f548bab7cb805af0d02586263d9a348dc18baf90efb142b029e2e7097
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true
_GO_LDFLAGS="
-X main.version=${CLANDRO_PKG_VERSION}
-X main.branch=${_GIT_BRANCH}
-X main.commit=${_COMMIT}
"

clandro_step_pre_configure() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	go mod tidy
}

clandro_step_make() {
	go install -ldflags="${_GO_LDFLAGS}" ./...
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin $GOPATH/bin/*/influx*
}
