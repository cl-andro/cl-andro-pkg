CLANDRO_PKG_HOMEPAGE=https://github.com/phpredis/phpredis
CLANDRO_PKG_DESCRIPTION="PHP extension for interfacing with Redis"
CLANDRO_PKG_LICENSE="PHP-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.3.0RC1"
CLANDRO_PKG_SRCURL=https://github.com/phpredis/phpredis/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=86867bb5214f058cfb0e1abb07524d7f9bfd097ce06e23286993308b1b281082
CLANDRO_PKG_DEPENDS=php
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+'


clandro_step_pre_configure() {
	$CLANDRO_PREFIX/bin/phpize
}
