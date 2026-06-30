## Note: APG project seems dead. Official homepage & src urls
## disappeared.

CLANDRO_PKG_HOMEPAGE=http://www.adel.nursat.kz/apg/index.shtml
CLANDRO_PKG_DESCRIPTION="Automated Password Generator"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.0b
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/termux/distfiles/releases/download/2021.01.04/apg-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d1e52029709e2d7f9cb99bedce3e02ee7a63cff7b8e2b4c2bc55b3dc03c28b92
CLANDRO_PKG_DEPENDS="libcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_extract_package() {
	# Fix permissions.
	find "$CLANDRO_PKG_SRCDIR" -type d -exec chmod 700 "{}" \;
	find "$CLANDRO_PKG_SRCDIR" -type f -executable -exec chmod 700 "{}" \;
	find "$CLANDRO_PKG_SRCDIR" -type f ! -executable -exec chmod 600 "{}" \;
}
