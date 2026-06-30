CLANDRO_PKG_HOMEPAGE=https://icecast.org
CLANDRO_PKG_DESCRIPTION="Icecast is a streaming media (audio/video) server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.5.0
CLANDRO_PKG_SRCURL="https://downloads.xiph.org/releases/icecast/icecast-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=d9aa07c7429aec19d950ff6fd425c371f77158cd34ff220fc191b2c186c67c7a
CLANDRO_PKG_DEPENDS="libcurl, libgnutls, libogg, libvorbis, libxml2, libxslt, media-types, openssl, libigloo"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology

clandro_step_pre_configure() {
	perl -p -i -e "s#/etc/mime.types#$CLANDRO_PREFIX/etc/mime.types#" $CLANDRO_PKG_SRCDIR/src/cfgfile.c
}
