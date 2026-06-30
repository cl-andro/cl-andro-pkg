CLANDRO_PKG_HOMEPAGE=https://github.com/AgentD/squashfs-tools-ng
CLANDRO_PKG_DESCRIPTION="New set of tools for working with SquashFS images"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/AgentD/squashfs-tools-ng/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=21f40dc82f69b721e92bfc539e47bfb8581753f8de492c877c59737ce2e3bf0f
CLANDRO_PKG_DEPENDS="liblz4, liblzma, liblzo, zlib, zstd"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure(){
	autoreconf -fi
}
