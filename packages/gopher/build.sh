CLANDRO_PKG_HOMEPAGE=gopher://gopher.quux.org/1/devel/gopher
CLANDRO_PKG_DESCRIPTION="University of Minnesota gopher"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.0.17.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://archive.ubuntu.com/ubuntu/pool/universe/g/gopher/gopher_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=584b4ffeaa5221bab94bc4934b644f64df35c955e7720f3cfff648072eb0370b
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lncursesw"
}
