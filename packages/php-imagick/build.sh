# Contributor: @ian4hu
CLANDRO_PKG_HOMEPAGE=https://github.com/Imagick/imagick
CLANDRO_PKG_DESCRIPTION="The Imagick PHP extension"
CLANDRO_PKG_LICENSE="PHP-3.01"
CLANDRO_PKG_LICENSE_FILE=LICENSE
CLANDRO_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
CLANDRO_PKG_VERSION="3.8.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Imagick/imagick/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b0e9279ddf6e75a8c6b4068e16daec0475427dbca7ce2e144e30a51a88aa5ddc
CLANDRO_PKG_DEPENDS="php, imagemagick"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+(?!RC)'

clandro_step_pre_configure() {
	$CLANDRO_PREFIX/bin/phpize

	if [ "$CLANDRO_ARCH_BITS" = 32 ]; then
		LDFLAGS+=" -lm"
	fi
}
