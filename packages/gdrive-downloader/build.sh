CLANDRO_PKG_HOMEPAGE=https://github.com/Akianonymus/gdrive-downloader
CLANDRO_PKG_DESCRIPTION="Download a gdrive folder or file easily, shell ftw"
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:1.1
CLANDRO_PKG_SRCURL=https://github.com/Akianonymus/gdrive-downloader/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=aa1bf1a0a2cd6cc714292b2e83cf38fa37b99aac8f9d80ee92d619f156ddf4ba
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS='bash, curl'
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -D release/bash/* -t "$CLANDRO_PREFIX/bin"
}
