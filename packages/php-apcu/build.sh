# Contributor: @ian4hu
CLANDRO_PKG_HOMEPAGE=http://php.net/apcu
CLANDRO_PKG_DESCRIPTION="APCu - APC User Cache"
CLANDRO_PKG_LICENSE="PHP-3.01"
CLANDRO_PKG_LICENSE_FILE=LICENSE
CLANDRO_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
CLANDRO_PKG_VERSION="5.1.28"
CLANDRO_PKG_SRCURL="https://github.com/krakjoe/apcu/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_DEPENDS="php"
CLANDRO_PKG_SHA256=0e60ba9d0fa4021c57a70c071f3d8f71de236275d084e560d5959fec4edd8c32
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	$CLANDRO_PREFIX/bin/phpize
	LDFLAGS+=" -landroid-shmem"
}
