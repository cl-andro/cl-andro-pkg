CLANDRO_PKG_HOMEPAGE=https://www.rsnapshot.org/
CLANDRO_PKG_DESCRIPTION="A remote filesystem snapshot utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.1"
CLANDRO_PKG_SRCURL=https://github.com/rsnapshot/rsnapshot/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=88d2b53d0807d6c7f9a803fc19f5a64fcb028d9dad6a880ca9941a1d5e730742
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="coreutils, openssh, perl, rsync"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-perl=$CLANDRO_PREFIX/bin/perl
--with-rsync=$CLANDRO_PREFIX/bin/rsync
--with-rm=$CLANDRO_PREFIX/bin/rm
--with-ssh=$CLANDRO_PREFIX/bin/ssh
--with-du=$CLANDRO_PREFIX/bin/du
"

CLANDRO_PKG_CONFFILES="etc/rsnapshot.conf"

clandro_step_pre_configure() {
	./autogen.sh
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc
	sed -e "s%\@CLANDRO_BASE_DIR\@%${CLANDRO_BASE_DIR}%g" \
		-e "s%\@CLANDRO_CACHE_DIR\@%${CLANDRO_CACHE_DIR}%g" \
		-e "s%\@CLANDRO_HOME\@%${CLANDRO_ANDROID_HOME}%g" \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		$CLANDRO_PKG_BUILDER_DIR/rsnapshot.conf > $CLANDRO_PREFIX/etc/rsnapshot.conf
}
