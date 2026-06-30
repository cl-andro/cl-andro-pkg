# Contributor: @PuneetGopinath
CLANDRO_PKG_HOMEPAGE=https://getcomposer.org/
CLANDRO_PKG_DESCRIPTION="Dependency Manager for PHP"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.9.7"
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_SRCURL=git+https://github.com/composer/composer
CLANDRO_PKG_DEPENDS="php"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-regex
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+(?!-)'

clandro_step_make_install() {
	composer install
	php -d phar.readonly=Off bin/compile
	install -Dm700 composer.phar $CLANDRO_PREFIX/bin/composer
}
