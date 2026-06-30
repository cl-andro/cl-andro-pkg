CLANDRO_PKG_HOMEPAGE=https://github.com/p7zip-project/p7zip
CLANDRO_PKG_DESCRIPTION="Command-line version of the 7zip compressed file archiver"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="17.06"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/p7zip-project/p7zip/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c35640020e8f044b425d9c18e1808ff9206dc7caf77c9720f57eb0849d714cd1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, libiconv"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	export CXXFLAGS="$CXXFLAGS $CPPFLAGS -Wno-c++11-narrowing"
	export LDFLAGS="$LDFLAGS -liconv"
	cp makefile.android_arm makefile.machine
}

clandro_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		make -j $CLANDRO_PKG_MAKE_PROCESSES 7z 7za OPTFLAGS="${CXXFLAGS}" DEST_HOME=$CLANDRO_PREFIX
}

clandro_step_make_install() {
	chmod +x install.sh
	make install DEST_HOME=$CLANDRO_PREFIX DEST_MAN=$CLANDRO_PREFIX/share/man
}
