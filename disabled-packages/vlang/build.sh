# Known issues:
#   https://github.com/termux/termux-packages/issues/7191
CLANDRO_PKG_HOMEPAGE=https://github.com/vlang/v
CLANDRO_PKG_DESCRIPTION="Simple, fast, safe, compiled language for developing maintainable software"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/vlang/v/archive/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9152eec96d2eeb575782cf138cb837f315e48c173878857441d98ba679e3a9bf
CLANDRO_PKG_DEPENDS="clang"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="ANDROID=1"

clandro_step_make_install() {
	install -Dm700 v "$CLANDRO_PREFIX"/libexec/vlang/v
	ln -sfr "$CLANDRO_PREFIX"/libexec/vlang/v "$CLANDRO_PREFIX"/bin/v
	rm -rf "$CLANDRO_PREFIX"/libexec/vlang/vlib
	cp -a cmd vlib "$CLANDRO_PREFIX"/libexec/vlang/
}

