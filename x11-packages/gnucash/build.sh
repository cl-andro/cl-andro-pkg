CLANDRO_PKG_HOMEPAGE="https://gnucash.org"
CLANDRO_PKG_DESCRIPTION="Personal and small-business financial-accounting software"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later" # with OpenSSL linking exceptions
CLANDRO_PKG_LICENSE_FILE="LICENSE"     # specified for additional nuance.
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/Gnucash/gnucash/releases/download/${CLANDRO_PKG_VERSION}/gnucash-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=b0bd4af43b6bde3454227d4b398e9ec7a0dbd5143469c1373fc824c3caab0909
CLANDRO_PKG_DEPENDS="boost, gettext, guile, glib, gtk3, libicu, libsecret, libxml2, libxslt, perl, python, swig, webkit2gtk-4.1, xsltproc, zlib"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, boost-headers, googletest"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_PYTHON=ON
-DWITH_SQL=OFF
-DWITH_OFX=OFF
-DWITH_AQBANKING=OFF
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_python_pip

	# gnc-autoclear.c:151:22: error: format string is not a string literal (potentially insecure)
	CFLAGS+=" -Wno-format-security"

	# ERROR: ./lib/libgnc-expressions.so contains undefined symbols log, pow, exp...
	LDFLAGS+=" -lm"

	# CANNOT LINK EXECUTABLE "gnucash": library "libgnc-qif-import.so" not found: needed by main executable
	LDFLAGS+=" -Wl,-rpath=$CLANDRO__PREFIX__LIB_DIR/$CLANDRO_PKG_NAME"

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_proot

	export LD_LIBRARY_PATH="$CLANDRO_PKG_BUILDDIR/lib:$CLANDRO_PKG_BUILDDIR/lib/$CLANDRO_PKG_NAME"
	mkdir -p "$CLANDRO_PKG_TMPDIR/bin"
	for tool in python guile; do
		# proot will append its own LD_LIBRARY_PATH which is incompatible with bionic
		cat > "$CLANDRO_PKG_TMPDIR/bin/$tool" <<-HERE
			#!$(command -v bash)
			LD_LIBRARY_PATH=$LD_LIBRARY_PATH
			exec $(command -v termux-proot-run) env LD_PRELOAD= LD_LIBRARY_PATH=\$LD_LIBRARY_PATH GUILE_LOAD_PATH=\$GUILE_LOAD_PATH GUILE_LOAD_COMPILED_PATH=\$GUILE_LOAD_COMPILED_PATH $CLANDRO_PREFIX/bin/$tool "\$@"
		HERE
	done
	chmod +x "$CLANDRO_PKG_TMPDIR/bin"/*
	ln -sf "$CLANDRO_PREFIX/bin/guild" "$CLANDRO_PKG_TMPDIR/bin/guild"
	PATH="$CLANDRO_PKG_TMPDIR/bin:$PATH"
}
