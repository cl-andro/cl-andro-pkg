CLANDRO_PKG_HOMEPAGE=https://github.com/leo-arch/clifm
CLANDRO_PKG_DESCRIPTION="The shell-like, command line terminal file manager: simple, fast, extensible, and lightweight as hell"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.27.1"
CLANDRO_PKG_SRCURL=https://github.com/leo-arch/clifm/releases/download/v${CLANDRO_PKG_VERSION}/clifm-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a35cd1ccbb83f1261c3c5b14b5b4733cf0555be68579b3cb19fa8b36076a5339
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcap, libacl, readline, file, libandroid-glob, libandroid-support"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-f misc/termux/Makefile"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
