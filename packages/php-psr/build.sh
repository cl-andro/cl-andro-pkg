# Contributor: @ian4hu
CLANDRO_PKG_HOMEPAGE=https://github.com/jbboehr/php-psr
CLANDRO_PKG_DESCRIPTION="PHP extension providing the accepted PSR interfaces"
CLANDRO_PKG_LICENSE="BSD Simplified"
CLANDRO_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
CLANDRO_PKG_VERSION=1.2.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/jbboehr/php-psr/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fa4071bedf625b3f434b4dbcc005913d291790039d03ae429bfea252f9ab2b54
CLANDRO_PKG_DEPENDS=php
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	$CLANDRO_PREFIX/bin/phpize
}
