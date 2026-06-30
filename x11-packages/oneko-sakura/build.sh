CLANDRO_PKG_HOMEPAGE=http://www.daidouji.com/oneko
CLANDRO_PKG_DESCRIPTION="oneko-sakurais modified version of oneko, KINOMOTO Sakura chases around your mouse cursor"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.sakura.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/tie/oneko
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libx11,libxext,xorgproto"
CLANDRO_PKG_CMAKE_BUILD="Unix Makefiles"
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/oneko
}
