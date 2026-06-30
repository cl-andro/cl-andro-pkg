CLANDRO_PKG_HOMEPAGE=https://www.torproject.org
CLANDRO_PKG_DESCRIPTION="The Onion Router anonymizing overlay network"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.9.8"
CLANDRO_PKG_SRCURL=https://www.torproject.org/dist/tor-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ac1f394e2dd2ab0877d27d928fd0d9e86662fe3ca6afdffb9fd9b6f0f96d05de
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libevent, liblzma, openssl, resolv-conf, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-glob"
# We're not using '--enable-android' as it just defines 'USE_ANDROID', which
# makes Tor writes the log to Android's logcat instead of to stdout/stderr, not
# helpful in our case. Although it would be good to go through the source and
# ensure that in future there is not any other Android specific behaviour which
# affects security/anonymity.
# without --disable-seccomp, tor would automatically enable seccomp if libseccomp was
# previously installed in $CLANDRO_PREFIX and fail with:
# src/lib/sandbox/sandbox.c:890:32: error: use of undeclared identifier 'PF_FILE'
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-zstd
--disable-unittests
--disable-seccomp
"
CLANDRO_PKG_CONFFILES="etc/tor/torrc"
CLANDRO_PKG_SERVICE_SCRIPT=("tor" 'exec tor 2>&1')

clandro_step_post_make_install() {
	# use default config
	mv "$CLANDRO_PREFIX/etc/tor/torrc.sample" "$CLANDRO_PREFIX/etc/tor/torrc"
}
