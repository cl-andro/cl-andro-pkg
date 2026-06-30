CLANDRO_PKG_HOMEPAGE=https://www.clamav.net/
CLANDRO_PKG_DESCRIPTION="Anti-virus toolkit for Unix"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.2"
CLANDRO_PKG_SRCURL="https://www.clamav.net/downloads/production/clamav-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=f34018cf22f05bdd9d1a1574ca07193e3e030ca52050c3e5c220e23a32314965
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="json-c, libandroid-support, libbz2, libc++, libcurl, libiconv, libxml2, ncurses, openssl, pcre2, zlib"
CLANDRO_PKG_BREAKS="clamav-dev"
CLANDRO_PKG_REPLACES="clamav-dev"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DAPP_CONFIG_DIRECTORY=$CLANDRO_PREFIX/etc/clamav
-DBYTECODE_RUNTIME=interpreter
-DENABLE_CLAMONACC=OFF
-DENABLE_MILTER=OFF
-DENABLE_TESTS=OFF
-Dtest_run_result=0
-Dtest_run_result__TRYRUN_OUTPUT=
"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/man/man5/clamav-milter.conf.5
share/man/man8/clamav-milter.8
share/man/man8/clamonacc.8
"
CLANDRO_PKG_CONFFILES="
etc/clamav/clamd.conf
etc/clamav/freshclam.conf"

clandro_step_pre_configure() {
	local _lib="$CLANDRO_PKG_BUILDDIR/_syncfs/lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"/..
	$CC $CFLAGS $CPPFLAGS "$CLANDRO_PKG_BUILDER_DIR/syncfs.c" \
		-fvisibility=hidden -c -o ./syncfs.o
	$AR cru "${_lib}"/libsyncfs.a ./syncfs.o
	popd

	LDFLAGS+=" -L${_lib} -l:libsyncfs.a"

	clandro_setup_rust
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DRUST_COMPILER_TARGET=$CARGO_TARGET_NAME"
}

clandro_step_post_make_install() {
	for conf in clamd.conf freshclam.conf; do
		sed "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
			"$CLANDRO_PKG_BUILDER_DIR"/$conf.in \
			> "$CLANDRO_PREFIX"/etc/clamav/$conf
	done
	unset conf
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/lib/clamav
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/log/clamav
}
