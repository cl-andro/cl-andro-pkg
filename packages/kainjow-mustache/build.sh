CLANDRO_PKG_HOMEPAGE=https://github.com/kainjow/Mustache
CLANDRO_PKG_DESCRIPTION="Mustache implementation for modern C++"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.1
CLANDRO_PKG_SRCURL=https://github.com/kainjow/Mustache/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=acd66359feb4318b421f9574cfc5a511133a77d916d0b13c7caa3783c0bfe167
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_configure() {
	:
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/include $CLANDRO_PKG_SRCDIR/mustache.hpp
}
