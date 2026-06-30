CLANDRO_PKG_HOMEPAGE=https://github.com/spook/sshping
CLANDRO_PKG_DESCRIPTION="measure character-echo latency and bandwidth for an interactive ssh session"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.4
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/spook/sshping/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=589623e3fbe88dc1d423829e821f9d57f09aef0d9a2f04b7740b50909217863a
CLANDRO_PKG_DEPENDS="libc++, libssh"
CLANDRO_PKG_EXTRA_MAKE_ARGS="sshping man"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	rm -f CMakeLists.txt
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ./bin/sshping
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man8 ./doc/sshping.8
}
