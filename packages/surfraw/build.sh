CLANDRO_PKG_HOMEPAGE=https://gitlab.com/surfraw/Surfraw
CLANDRO_PKG_DESCRIPTION="Shell Users' Revolutionary Front Rage Against the Web"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.0
CLANDRO_PKG_REVISION=10
CLANDRO_PKG_SRCURL=https://gitlab.com/surfraw/Surfraw/-/archive/surfraw-${CLANDRO_PKG_VERSION}/Surfraw-surfraw-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b5e2b451a822ed437b165a5c81d8448570ee590db902fcd8174d6c51fcc4a16d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="lynx, perl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	./prebuild
}
