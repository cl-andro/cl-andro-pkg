CLANDRO_PKG_HOMEPAGE=https://www.privoxy.org
CLANDRO_PKG_DESCRIPTION="Non-caching web proxy with advanced filtering capabilities"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.GPLv3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/ijbswa/Sources/$CLANDRO_PKG_VERSION%20%28stable%29/privoxy-$CLANDRO_PKG_VERSION-stable-src.tar.gz
CLANDRO_PKG_SHA256=c08e2ba0049307017bf9d8a63dd2a0dfb96aa0cdeb34ae007776e63eba62a26f
# Termux-services adds the run scripts to CLANDRO_PKG_CONFFILES. Those ones can
# not be copied in clandro_step_post_massage so setup special variable for that
DEFAULT_CONFFILES="\
etc/privoxy/config
etc/privoxy/match-all.action
etc/privoxy/trust
etc/privoxy/user.action
etc/privoxy/user.filter
etc/privoxy/default.action
etc/privoxy/default.filter"
CLANDRO_PKG_CONFFILES=$DEFAULT_CONFFILES
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc/privoxy
"
CLANDRO_PKG_DEPENDS="pcre2, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SERVICE_SCRIPT=("privoxy"
"if [ -f \"$CLANDRO_ANDROID_HOME/.config/privoxy/config\" ]; then \
CONFIG=\"$CLANDRO_ANDROID_HOME/.config/privoxy/config\"; else \
CONFIG=\"$CLANDRO_PREFIX/etc/privoxy/config\"; fi\n\
exec privoxy --no-daemon \$CONFIG 2>&1")

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	autoheader
	autoconf
}

clandro_step_post_massage() {
	# copy default config files
	for f in $DEFAULT_CONFFILES; do
		cp "$CLANDRO_PKG_SRCDIR/$(basename $f)" \
			"$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/$f"
	done
}
