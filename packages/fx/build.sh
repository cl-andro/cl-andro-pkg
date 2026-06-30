CLANDRO_PKG_HOMEPAGE="https://github.com/antonmedv/fx"
CLANDRO_PKG_DESCRIPTION="Interactive JSON viewer on your terminal"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="39.2.0"
CLANDRO_PKG_SRCURL="https://github.com/antonmedv/fx/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=cdb98177f956615c961bc615fab0b30e73167295152d4f2d4cb70b16cdf47d6e
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	mkdir bin
	go build -o ./bin -trimpath
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/*
}
