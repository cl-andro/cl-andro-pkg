# Contributor: @DLC01
CLANDRO_PKG_HOMEPAGE=https://github.com/nu774/fdkaac
CLANDRO_PKG_DESCRIPTION="command line encoder frontend for libfdk-aac"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.7"
CLANDRO_PKG_SRCURL=https://github.com/nu774/fdkaac/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=145d4684c9325a2bd650e46a04b03327abe780a7b59cce47e6de8af2064fb2c7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libfdk-aac"

clandro_step_pre_configure() {
	autoreconf -fi
}
