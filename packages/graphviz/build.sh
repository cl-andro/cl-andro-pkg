CLANDRO_PKG_HOMEPAGE=https://www.graphviz.org/
CLANDRO_PKG_DESCRIPTION="Rich set of graph drawing tools"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="14.1.5"
CLANDRO_PKG_SRCURL=https://gitlab.com/graphviz/graphviz/-/archive/$CLANDRO_PKG_VERSION/graphviz-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2cb3136bffb335346e9c5c99a7c615df32295839a6498df44f576adfc2937a93
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, libandroid-glob, libc++, libcairo, libexpat, libgd, libgts, libltdl, librsvg, libwebp, pango, zlib"
CLANDRO_PKG_BREAKS="graphviz-dev"
CLANDRO_PKG_REPLACES="graphviz-dev"
CLANDRO_PKG_BUILD_DEPENDS="libtool"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-guile=no
--enable-java=no
--enable-lua=no
--enable-ocaml=no
--enable-perl=no
--enable-php=no
--enable-python=no
--enable-r=no
--enable-ruby=no
--enable-sharp=no
--enable-swig=no
--enable-tcl=no
--with-ann=no
--with-expatlibdir=$CLANDRO_PREFIX/lib
--with-ltdl-include=$CLANDRO_PREFIX/include
--with-ltdl-lib=$CLANDRO_PREFIX/lib
--with-pangocairo=yes
--with-pic
--with-poppler=no
--with-x=no
"
CLANDRO_PKG_FORCE_CMAKE=false
CLANDRO_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"

clandro_step_pre_configure() {
	./autogen.sh NOCONFIG
	export HOSTCC="gcc"

	# ERROR: ./lib/graphviz/libgvplugin_neato_layout.so contains undefined symbols: __extendsftf2
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"

	LDFLAGS+=" -lm -landroid-glob"
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/graphviz"

	chmod +x "$CLANDRO_PKG_SRCDIR/lib/common/make_colortbl.py"
	chmod +x "$CLANDRO_PKG_SRCDIR/lib/common/entities.py"
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "dot -c" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
