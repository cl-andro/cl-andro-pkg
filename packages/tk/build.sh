CLANDRO_PKG_HOMEPAGE=https://tcl.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A windowing toolkit for use with tcl"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="license.terms"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.6.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/tcl/tk${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=8ffdb720f47a6ca6107eac2dd877e30b0ef7fac14f3a84ebbd0b3612cee41a94
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="fontconfig, libx11, libxft, libxss, tcl"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_MAKE_INSTALL_TARGET="install install-private-headers"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
--enable-threads
--enable-64bit
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/unix"
}

clandro_step_post_make_install() {
	ln -sfr "$CLANDRO_PREFIX/bin/wish${CLANDRO_PKG_VERSION:0:3}" \
		"$CLANDRO_PREFIX"/bin/wish
	ln -sfr "$CLANDRO_PREFIX/lib/libtk${CLANDRO_PKG_VERSION:0:3}.so" \
		"$CLANDRO_PREFIX"/lib/libtk.so

	cd "$CLANDRO_PKG_SRCDIR"/../

	for dir in compat generic generic/ttk unix; do
		install -dm755 "$CLANDRO_PREFIX/include/tk-private/$dir"
		install -m644 -t "$CLANDRO_PREFIX/include/tk-private/$dir" "$dir"/*.h
	done
}
