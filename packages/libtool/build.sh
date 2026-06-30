CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
CLANDRO_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=da8ebb2ce4dcf46b90098daf962cffa68f4b4f62ea60f798d0ef12929ede6adf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, grep, sed, libltdl"
CLANDRO_PKG_CONFLICTS="libtool-dev, libtool-static"
CLANDRO_PKG_REPLACES="libtool-dev, libtool-static"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_GROUPS="base-devel"

clandro_step_post_make_install() {
	perl -p -i -e \
		"s|\"/usr/bin/|\"$CLANDRO_PREFIX/bin/|;s|\"/bin/|\"$CLANDRO_PREFIX/bin/|" \
		$CLANDRO_PREFIX/bin/{libtool,libtoolize}
}
