CLANDRO_PKG_HOMEPAGE=https://git-lfs.github.com/
CLANDRO_PKG_DESCRIPTION="Git extension for versioning large files"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.7.1"
CLANDRO_PKG_SRCURL=https://github.com/git-lfs/git-lfs/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=0e83566a9e2477e03627e7fd6bf81f01fadbf93dcaf6abd2686fca90f6bac7dd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	! $CLANDRO_ON_DEVICE_BUILD && GOOS=linux GOARCH=amd64 CC=gcc LD=gcc go generate ./commands
	go build git-lfs.go
}

clandro_step_make_install() {
	install -Dm700 git-lfs "$CLANDRO_PREFIX"/bin/git-lfs
}
