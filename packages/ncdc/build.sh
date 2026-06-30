CLANDRO_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdc
CLANDRO_PKG_DESCRIPTION="Modern and lightweight direct connect client with a friendly ncurses interface"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.25"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dev.yorhel.nl/download/ncdc-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b9be58e7dbe677f2ac1c472f6e76fad618a65e2f8bf1c7b9d3d97bc169feb740
CLANDRO_PKG_DEPENDS="glib, libbz2, libgnutls, libsqlite, ncurses, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_configure() {
	# Cross compiling steps documented in ncdc README
	gcc $CLANDRO_PKG_SRCDIR/deps/makeheaders.c -o makeheaders
	gcc -I. $CLANDRO_PKG_SRCDIR/doc/gendoc.c -o gendoc
	touch -d "next hour" makeheaders gendoc
}
