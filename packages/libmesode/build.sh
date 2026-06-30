# Contributor: @Neo-Oli
CLANDRO_PKG_HOMEPAGE=https://github.com/boothj5/libmesode
CLANDRO_PKG_DESCRIPTION="Minimal XMPP library written for use with Profanity XMPP client"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_VERSION=0.10.1
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
CLANDRO_PKG_SRCURL=https://github.com/boothj5/libmesode/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c9dd90648e73d92b90f2b0ae41a75d8f469b116d3e6aa297c14cd57be937d99e
CLANDRO_PKG_DEPENDS="openssl,libexpat"
CLANDRO_PKG_BREAKS="libmesode-dev"
CLANDRO_PKG_REPLACES="libmesode-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
./bootstrap.sh
}
