CLANDRO_PKG_HOMEPAGE=https://wiki.linuxquestions.org/wiki/Corkscrew
CLANDRO_PKG_DESCRIPTION="A tool for tunneling SSH through HTTP proxies"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/termux/distfiles/releases/download/2021.01.04/corkscrew-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0d0fcbb41cba4a81c4ab494459472086f377f9edb78a2e2238ed19b58956b0be
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="openssh"

clandro_step_post_make_install() {
	# Corkscrew does not distribute a man page, use one from debian:
	mkdir -p $CLANDRO_PREFIX/share/man/man1
	cp $CLANDRO_PKG_BUILDER_DIR/corkscrew.1 $CLANDRO_PREFIX/share/man/man1
}
