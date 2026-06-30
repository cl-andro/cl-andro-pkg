CLANDRO_PKG_HOMEPAGE=https://github.com/coin-or/CoinUtils
CLANDRO_PKG_DESCRIPTION="An open-source collection of classes and helper functions for COIN-OR projects"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:2.11.11
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=27da344479f38c82112d738501643dcb229e4ee96a5f87d4f406456bdc1b2cb4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
