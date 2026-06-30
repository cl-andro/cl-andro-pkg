CLANDRO_PKG_HOMEPAGE=https://github.com/jtyr/gbt
CLANDRO_PKG_DESCRIPTION="Highly configurable prompt builder for Bash and ZSH written in Go"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.0
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://github.com/jtyr/gbt/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b324695dc432e8e22bc257f7a6ec576f482ec418fb9c9a8301f47bfdf7766998
CLANDRO_PKG_AUTO_UPDATE=true
_COMMIT=29dc3dac6c06518073a8e879d2b6ec65291ddab2

clandro_step_make_install() {
	cd $CLANDRO_PKG_SRCDIR

	clandro_setup_golang

	export GOPATH=$HOME/go
	mkdir -p $GOPATH/{bin,pkg,src/github.com/jtyr}
	ln -fs $CLANDRO_PKG_SRCDIR $GOPATH/src/github.com/jtyr/gbt

	go mod init gbt
	go mod tidy
	go build -ldflags="-s -w -X main.version=$CLANDRO_PKG_VERSION -X main.build=${_COMMIT::6}" -o $CLANDRO_PREFIX/bin/gbt github.com/jtyr/gbt/cmd/gbt

	mkdir -p $CLANDRO_PREFIX/{doc/gbt,share/gbt}
	cp -r $CLANDRO_PKG_SRCDIR/{sources,themes} $CLANDRO_PREFIX/share/gbt/
	cp -r $CLANDRO_PKG_SRCDIR/{LICENSE,README.md} $CLANDRO_PREFIX/doc/gbt/
}
