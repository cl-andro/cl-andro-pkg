CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/dict/
CLANDRO_PKG_DESCRIPTION="Online dictionary client and server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/dict/dictd/dictd-${CLANDRO_PKG_VERSION}/dictd-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=192129dfb38fa723f48a9586c79c5198fc4904fec1757176917314dd073f1171
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libmaa, zlib"
CLANDRO_PKG_CONFFILES="etc/dict.conf"
CLANDRO_PKG_EXTRA_MAKE_ARGS="LEX=flex"

clandro_step_post_make_install() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/dict.conf $CLANDRO_PREFIX/etc/dict.conf
}
