CLANDRO_PKG_HOMEPAGE=https://www.lighttpd.net
CLANDRO_PKG_DESCRIPTION="Fast webserver with minimal memory footprint"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.82"
CLANDRO_PKG_SRCURL=https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=abfe74391f9cbd66ab154ea07e64f194dbe7e906ef4ed47eb3b0f3b46246c962
CLANDRO_PKG_DEPENDS="libandroid-glob, libandroid-spawn, libbz2, libcrypt, openssl, pcre2, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dwith_bzip=enabled
-Dwith_openssl=true
-Dwith_zlib=enabled
"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/lighttpd-angel"
CLANDRO_PKG_SERVICE_SCRIPT=("lighttpd" "if [ -f \"$CLANDRO_ANDROID_HOME/.lighttpd/lighttpd.conf\" ]; then CONFIG=\"$CLANDRO_ANDROID_HOME/.lighttpd/lighttpd.conf\"; else CONFIG=\"$CLANDRO_PREFIX/etc/lighttpd/lighttpd.conf\"; fi\nexec lighttpd -D -f \$CONFIG 2>&1")

CLANDRO_PKG_CONFFILES="
etc/lighttpd/lighttpd.conf
etc/lighttpd/modules.conf
"

clandro_step_post_get_source() {
	mv CMakeLists.txt{,.unused}
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-spawn"
}

clandro_step_post_make_install() {
	# Install example config file
	install -Dm600 -t $CLANDRO_PREFIX/etc/lighttpd/ \
		$CLANDRO_PKG_SRCDIR/doc/config/lighttpd.conf \
		$CLANDRO_PKG_SRCDIR/doc/config/modules.conf
	install -Dm600 -t $CLANDRO_PREFIX/etc/lighttpd/conf.d \
		$CLANDRO_PKG_SRCDIR/doc/config/conf.d/*.conf
	install -Dm600 -t $CLANDRO_PREFIX/etc/lighttpd/vhosts.d \
		$CLANDRO_PKG_SRCDIR/doc/config/vhosts.d/vhosts.template

	cd $CLANDRO_PKG_SRCDIR/doc/config
	CLANDRO_PKG_CONFFILES+="$(find conf.d -type f -iname "*.conf" | sed -E 's/(.*)/etc\/lighttpd\/\1/g')"
}
