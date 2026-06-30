CLANDRO_PKG_HOMEPAGE=https://pagure.io/mailcap
CLANDRO_PKG_DESCRIPTION="List of standard media types and their usual file extension"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="14.0.0"
CLANDRO_PKG_SRCURL=https://salsa.debian.org/debian/media-types/-/archive/debian/${CLANDRO_PKG_VERSION}/media-types-debian-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=55224557676d1d073b1c39ab9c26acfaab7ffe52bd1f6e013e652955da8850bb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BREAKS="mime-support"
CLANDRO_PKG_REPLACES="mime-support"
CLANDRO_PKG_PROVIDES="mime-support"
CLANDRO_PKG_CONFFILES="etc/mime.types"
# etc/mime.types was previously in mutt:
CLANDRO_PKG_CONFLICTS="mutt (<< 1.8.3-1)"

clandro_step_make_install() {
	install -Dm600 "$CLANDRO_PKG_SRCDIR/mime.types" "$CLANDRO_PREFIX/etc/mime.types"
}
