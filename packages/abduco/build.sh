CLANDRO_PKG_HOMEPAGE=https://www.brain-dump.org/projects/abduco/
CLANDRO_PKG_DESCRIPTION="Clean and simple terminal session manager"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://www.brain-dump.org/projects/abduco/abduco-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c90909e13fa95770b5afc3b59f311b3d3d2fdfae23f9569fa4f96a3e192a35f4
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="dvtm"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}
