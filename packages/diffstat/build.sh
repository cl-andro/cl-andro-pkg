CLANDRO_PKG_HOMEPAGE=https://invisible-island.net/diffstat/diffstat.html
CLANDRO_PKG_DESCRIPTION="Displays a histogram of changes to a file"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.69"
CLANDRO_PKG_SRCURL=https://github.com/ThomasDickey/diffstat-snapshots/archive/refs/tags/v${CLANDRO_PKG_VERSION/./_}.tar.gz
# invisible-mirror.net is not suitable for CI due to bad responsiveness.
#CLANDRO_PKG_SRCURL=https://invisible-mirror.net/archives/diffstat/diffstat-${CLANDRO_PKG_VERSION}.tgz
#CLANDRO_PKG_SRCURL=https://invisible-island.net/datafiles/release/diffstat.tar.gz
CLANDRO_PKG_SHA256=5787343604122c26c27bdeb3d0d0a94d09e01aa1be7afeac32cab41a3fb3c3c4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
