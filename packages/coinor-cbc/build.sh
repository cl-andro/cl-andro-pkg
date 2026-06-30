CLANDRO_PKG_HOMEPAGE=https://github.com/coin-or/Cbc
CLANDRO_PKG_DESCRIPTION="An open-source mixed integer linear programming solver"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.10.13"
CLANDRO_PKG_SRCURL=https://github.com/coin-or/Cbc/archive/refs/tags/releases/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=62fde44dcf6f3d05c5cd291d7435cdd1b7e8acd3c78ec481dd39fe49cbc40399
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="coinor-clp, libc++, libcoinor-cgl, libcoinor-osi, libcoinor-utils"

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
