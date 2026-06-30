CLANDRO_PKG_HOMEPAGE=https://github.com/rgburke/grv
CLANDRO_PKG_DESCRIPTION="A terminal based interface for viewing Git repositories"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.3.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/rgburke/grv
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgit2, ncurses, ncurses-ui-libs, readline"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	export GO111MODULE=off
	export GOPATH=$CLANDRO_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	ln -sfT $CLANDRO_PKG_SRCDIR/cmd/grv/vendor $GOPATH/src
}

clandro_step_make() {
	local _DATE=$(date -u '+%Y-%m-%d %H:%M:%S %Z')
	go build -ldflags "-X \"main.version=$CLANDRO_PKG_VERSION\" -X \"main.buildDateTime=$_DATE\"" \
		./cmd/grv
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin grv
}
