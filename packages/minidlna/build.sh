CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/minidlna/
CLANDRO_PKG_DESCRIPTION="A server software with the aim of being fully compliant with DLNA/UPnP-AV clients"
CLANDRO_PKG_LICENSE="GPL-2.0, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENCE.miniupnpd"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.3
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://git.code.sf.net/p/minidlna/git
CLANDRO_PKG_GIT_BRANCH=v${CLANDRO_PKG_VERSION//./_}
CLANDRO_PKG_DEPENDS="ffmpeg, libexif, libflac, libiconv, libid3tag, libjpeg-turbo, libogg, libsqlite, libvorbis"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_CONFFILES="etc/minidlna.conf"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-log-path=$CLANDRO_PREFIX/var/log
--with-db-path=$CLANDRO_PREFIX/var/cache/minidlna
"

clandro_step_pre_configure() {
	./autogen.sh
}

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/etc minidlna.conf
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/cache/minidlna
	EOF

	cat <<- EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	if [ "$CLANDRO_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	exit 0
	fi
	rm -rf $CLANDRO_PREFIX/var/cache/minidlna
	EOF
}
