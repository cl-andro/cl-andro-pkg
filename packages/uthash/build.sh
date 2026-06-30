CLANDRO_PKG_HOMEPAGE=https://troydhanson.github.io/uthash/
CLANDRO_PKG_DESCRIPTION="C preprocessor implementations of a hash table and a linked list"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.0
CLANDRO_PKG_SRCURL=https://github.com/troydhanson/uthash/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e10382ab75518bad8319eb922ad04f907cb20cccb451a3aa980c9d005e661acc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	cd src
	install -Dm600 -t $CLANDRO_PREFIX/include *.h
}
