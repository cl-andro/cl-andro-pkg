CLANDRO_PKG_HOMEPAGE=https://github.com/vapier/ncompress
CLANDRO_PKG_DESCRIPTION="The classic unix compression utility which can handle the ancient .Z archive"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/vapier/ncompress/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=96ec931d06ab827fccad377839bfb91955274568392ddecf809e443443aead46
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/share/man/man1/
	install -Dm700 compress "$CLANDRO_PREFIX"/bin/
	install -Dm600 compress.1 "$CLANDRO_PREFIX"/share/man/man1/
}
