CLANDRO_PKG_HOMEPAGE=https://github.com/coin-or/Clp
CLANDRO_PKG_DESCRIPTION="An open-source linear programming solver"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:1.17.11"
CLANDRO_PKG_SRCURL=https://github.com/coin-or/Clp/archive/refs/tags/releases/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=2c078e174dc1a7a308e091b6256fb34b4017897fc140ea707ba207b2913ea46d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++, libcoinor-osi, libcoinor-utils"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
