CLANDRO_PKG_HOMEPAGE=https://github.com/maaslalani/slides
CLANDRO_PKG_DESCRIPTION="Slides in your terminal"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.9.0"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/maaslalani/slides/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=fcce0dbbe767e0b1f0800e4ea934ee9babbfb18ab2ec4b343e3cd6359cd48330
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	cd "$CLANDRO_PKG_SRCDIR"
	make build
}

clandro_step_make_install() {
	install -Dm700 \
		"$CLANDRO_PKG_SRCDIR"/slides \
		"$CLANDRO_PREFIX"/bin/
}
