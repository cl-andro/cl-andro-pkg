CLANDRO_PKG_HOMEPAGE=https://github.com/schollz/croc
CLANDRO_PKG_DESCRIPTION="Easily and securely send things from one computer to another"
CLANDRO_PKG_LICENSE=MIT
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:10.4.3"
CLANDRO_PKG_SRCURL=https://github.com/schollz/croc/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=f70f6d504688ebf53eb297c2cff2759eeed91af261abe5e5916b9241f6f229ea
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	cd $CLANDRO_PKG_SRCDIR

	clandro_setup_golang

	# See https://github.com/wlynxg/anet?tab=readme-ov-file#how-to-build-with-go-1230-or-later
	# regarding -ldflags=-checklinkname=0:
	go build -ldflags=-checklinkname=0 -o croc -trimpath
}

clandro_step_make_install() {
	install -m755 croc $CLANDRO_PREFIX/bin/croc
}
