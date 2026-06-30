CLANDRO_PKG_HOMEPAGE=https://github.com/Dj-Codeman/dog_community
CLANDRO_PKG_DESCRIPTION="A command-line DNS client"
CLANDRO_PKG_LICENSE="EUPL-1.2"
CLANDRO_PKG_LICENSE_FILE="LICENCE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2.8
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/Dj-Codeman/dog_community/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4ad82572271bc4601ac3b9b5f68be83f2659bdb5370c1b19297ecf3bd964f957
CLANDRO_PKG_REPLACES="dog"
CLANDRO_PKG_DEPENDS="openssl, resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	rm $CLANDRO_PKG_SRCDIR/makefile
}
