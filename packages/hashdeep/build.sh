CLANDRO_PKG_HOMEPAGE=https://md5deep.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Programs to compute hashsums of arbitrary number of files recursively"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.4
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL=https://github.com/jessek/hashdeep/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ad78d42142f9a74fe8ec0c61bc78d6588a528cbb9aede9440f50b6ff477f3a7f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	sh bootstrap.sh
}
