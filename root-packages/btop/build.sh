CLANDRO_PKG_HOMEPAGE=https://github.com/aristocratos/btop
CLANDRO_PKG_DESCRIPTION="Resource monitor that shows usage and stats for processor, memory, disks, network and processes."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@tstein <me@tedstein.net>"
CLANDRO_PKG_VERSION="1.4.7"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=https://github.com/aristocratos/btop/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=933de2e4d1b2211a638be463eb6e8616891bfba73aef5d38060bd8319baeefc6
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, lowdown"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
	-DBTOP_LTO=OFF
	-DBTOP_GPU=OFF
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_proot
	mkdir "${CLANDRO_PKG_TMPDIR}/bin"
	printf '%s\ntermux-proot-run %s "$@"\n' \
		"#!/bin/sh" \
		"${CLANDRO_PREFIX}/bin/lowdown" \
	> "${CLANDRO_PKG_TMPDIR}/bin/lowdown"
	chmod +x "${CLANDRO_PKG_TMPDIR}/bin/lowdown"

	PATH="${CLANDRO_PKG_TMPDIR}/bin:$PATH"

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLOWDOWN_EXECUTABLE=${CLANDRO_PKG_TMPDIR}/bin/lowdown"
}
