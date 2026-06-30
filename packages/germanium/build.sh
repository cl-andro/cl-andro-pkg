# Contributor: @ravener
CLANDRO_PKG_HOMEPAGE=https://github.com/matsuyoshi30/germanium
CLANDRO_PKG_DESCRIPTION="Generate image from source code"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.3"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/matsuyoshi30/germanium/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=69c818f06bbd7ea562afb5ed38b24fc2e9e9a447d5668d995314da5203e72de3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go get -d ./cmd/germanium
	chmod +w $GOPATH -R
}

clandro_step_make() {
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go build -o germanium -v ./cmd/germanium
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin germanium
}
