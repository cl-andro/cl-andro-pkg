# Contributor: @ian4hu
CLANDRO_PKG_HOMEPAGE=https://github.com/phalcon/php-zephir-parser
CLANDRO_PKG_DESCRIPTION="The Zephir Parser delivered as a C extension for the PHP language"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
CLANDRO_PKG_VERSION="2.0.0"
CLANDRO_PKG_SRCURL=https://github.com/zephir-lang/php-zephir-parser/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f66d6d012f5c1485417d95f25db4da8c9d3cc0b8ec66e231fad8cad57c8e2e1d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS=php
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_pre_configure() {
	# copy host build `lemon`
	cp "$CLANDRO_PKG_HOSTBUILD_DIR/lemon" $CLANDRO_PKG_SRCDIR/parser/
	$CLANDRO_PREFIX/bin/phpize
}

clandro_step_host_build() {
	# lemon excuted by build host, so we need build it by hostbuild, then it will be reused by later build
	gcc -o "$CLANDRO_PKG_HOSTBUILD_DIR/lemon" $CLANDRO_PKG_SRCDIR/parser/lemon.c

}
