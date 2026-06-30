CLANDRO_PKG_HOMEPAGE=http://smalltalk.gnu.org/
CLANDRO_PKG_DESCRIPTION="A free implementation of the Smalltalk-80 language"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION=3.2.91
CLANDRO_PKG_REVISION=15
CLANDRO_PKG_SRCURL=ftp://alpha.gnu.org/gnu/smalltalk/smalltalk-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=13a7480553c182dbb8092bd4f215781b9ec871758d1db7045c2d8587e4d1bef9
CLANDRO_PKG_DEPENDS="gdbm, glib, libandroid-support, libexpat, libffi, libgmp, libiconv, libltdl, libsigsegv, libsqlite, zlib"
CLANDRO_PKG_BREAKS="smalltalk-dev"
CLANDRO_PKG_REPLACES="smalltalk-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	(cd "$CLANDRO_PKG_SRCDIR"
		autoreconf -i
		sed 's/int yylineno = 1;//g' -i libgst/genpr-scan.l
		sed 's/int yylineno = 1;//g' -i libgst/genvm-scan.l
		sed 's/int yylineno = 1;//g' -i libgst/genbc-scan.l
	)

	# Building bloxtk on archlinux fails with this error: https://bugs.gentoo.org/582936
	"$CLANDRO_PKG_SRCDIR"/configure --disable-gtk --disable-bloxtk
	make
}

clandro_step_pre_configure() {
	autoreconf -fi

	export LD_LIBRARY_PATH="$CLANDRO_PKG_HOSTBUILD_DIR/libgst/.libs"
	sed -i \
		"s%@CLANDRO_PKG_HOSTBUILD_DIR@%$CLANDRO_PKG_HOSTBUILD_DIR%g" \
		"$CLANDRO_PKG_SRCDIR"/Makefile.in
}
