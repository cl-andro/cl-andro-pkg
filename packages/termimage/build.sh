CLANDRO_PKG_HOMEPAGE=https://github.com/nabijaczleweli/termimage
CLANDRO_PKG_DESCRIPTION="Terminal image viewer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/nabijaczleweli/termimage/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a6f21c2675ec259975b106cde8688f876d9799c4453ff983c849c9f193ecda88
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
