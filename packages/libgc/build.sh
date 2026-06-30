CLANDRO_PKG_HOMEPAGE=https://www.hboehm.info/gc/
CLANDRO_PKG_DESCRIPTION="Library providing the Boehm-Demers-Weiser conservative garbage collector"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="README.QUICK"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.2.12"
CLANDRO_PKG_SRCURL=https://github.com/bdwgc/bdwgc/releases/download/v$CLANDRO_PKG_VERSION/gc-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=42e5194ad06ab6ffb806c83eb99c03462b495d979cda782f3c72c08af833cd4e
CLANDRO_PKG_BREAKS="libgc-dev"
CLANDRO_PKG_REPLACES="libgc-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-libatomic-ops=none"
CLANDRO_PKG_RM_AFTER_INSTALL="share/gc"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.[1-9]\d*" # all excluding experimental releases (ending with ".0")

clandro_step_post_get_source() {
	./autogen.sh
}
