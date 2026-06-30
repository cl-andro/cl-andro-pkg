# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/coder/wush/
CLANDRO_PKG_DESCRIPTION="simplest & fastest way to transfer files between computers"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/coder/wush/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=77d5a912465d1e8ec478252a9a69a04d39af75a126ac9ed94823f33a60b3d8f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	export GOOS="android"
	cd $CLANDRO_PKG_SRCDIR/cmd/wush
	go get
	chmod +w $GOPATH -R
}

clandro_step_make() {
	cd $CLANDRO_PKG_SRCDIR/cmd/wush
	local _Commit=$(git ls-remote --tags https://github.com/coder/wush.git | grep refs/tags/v$CLANDRO_PKG_VERSION | grep '\^{}' | awk '{print $1}')
	local _UnixTimeStamp=$(date +%s)
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go build -o wush -ldflags="-s -w -X main.version=$CLANDRO_PKG_VERSION -X main.commit=$_Commit -X main.commitDate=$_UnixTimeStamp"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$CLANDRO_PKG_SRCDIR/cmd/wush/wush"
}
