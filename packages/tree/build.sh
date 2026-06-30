CLANDRO_PKG_HOMEPAGE=http://mama.indstate.edu/users/ice/tree/
CLANDRO_PKG_DESCRIPTION="Recursive directory lister producing a depth indented listing of files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.2"
CLANDRO_PKG_SRCURL="https://gitlab.com/OldManProgrammer/unix-tree/-/archive/${CLANDRO_PKG_VERSION}/unix-tree-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=513a53cbc42ca1f4ea06af2bab1f5283524a3848266b1d162416f8033afc4985
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libandroid-support"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS $CPPFLAGS -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" \
		LDFLAGS="$LDFLAGS"
}

clandro_step_make_install() {
	make install \
		PREFIX="$CLANDRO_PREFIX" \
		MANDIR="$CLANDRO_PREFIX/share/man/man1"
}
