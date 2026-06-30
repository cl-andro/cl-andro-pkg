CLANDRO_PKG_HOMEPAGE=http://www.gnumeric.org/
CLANDRO_PKG_DESCRIPTION="The GNOME spreadsheet"
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.12.61"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gnumeric/${CLANDRO_PKG_VERSION%.*}/gnumeric-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2ac135d856572713c1a408b76b50a59f2a9769ed21f1213446b5af255df20a12
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, goffice, gtk3, libcairo, libgsf, libxml2, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_RECOMMENDS="gnumeric-help"
CLANDRO_PKG_SUGGESTS="glpk"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PYTHON=python
--enable-introspection=yes
--without-gda
--without-psiconv
--without-paradox
--without-long-double
--without-perl
"
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/locale
"

clandro_step_pre_configure() {
	clandro_setup_gir

	echo "Applying plugins-python-loader-Makefile.in.diff"
	sed "s|@PYTHON_VERSION@|${CLANDRO_PYTHON_VERSION}|g" \
		$CLANDRO_PKG_BUILDER_DIR/plugins-python-loader-Makefile.in.diff \
		| patch --silent -p1

	export PYTHON_GIOVERRIDESDIR=$CLANDRO_PYTHON_HOME/site-packages/gi/overrides
	export PYTHON_CONFIG=$CLANDRO_PREFIX/bin/python-config

	unset PYTHONPATH

	CPPFLAGS+=" -D__USE_GNU"
}

clandro_step_post_configure() {
	touch ./src/g-ir-scanner

	local ver=$(awk '/^PACKAGE_VERSION =/ { print $3 }' Makefile)
	local so=$CLANDRO_PREFIX/lib/libspreadsheet.so
	rm -f ${so}
	echo "INPUT(-lspreadsheet-${ver})" > ${so}

	# Workaround for https://github.com/android/ndk/issues/201
	local plugins_libs="-L$CLANDRO_PKG_BUILDDIR/src/.libs -lspreadsheet"
	plugins_libs+=" $($PKG_CONFIG libgoffice-0.10 --libs)"
	plugins_libs+=" $($PKG_CONFIG libgsf-1 --libs)"
	plugins_libs+=" $($PKG_CONFIG gtk+-3.0 --libs)"
	plugins_libs+=" $($PKG_CONFIG gmodule-2.0 --libs)"
	find plugins -name Makefile | xargs -n 1 \
		sed -i 's|^LIBS = |\0'"${plugins_libs}"' |g'

	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
