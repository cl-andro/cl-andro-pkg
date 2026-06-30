CLANDRO_PKG_HOMEPAGE=https://github.com/coin-or/Cgl
CLANDRO_PKG_DESCRIPTION="An open-source cut generation library for COIN-OR projects"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.60.8
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/coin-or/Cgl/archive/refs/tags/releases/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=1482ba38afb783d124df8d5392337f79fdd507716e9f1fb6b98fc090acd1ad96
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="coinor-clp, libc++, libcoinor-osi, libcoinor-utils"

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
