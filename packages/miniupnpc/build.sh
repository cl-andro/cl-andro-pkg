CLANDRO_PKG_HOMEPAGE=https://miniupnp.tuxfamily.org/
CLANDRO_PKG_DESCRIPTION="Small UPnP client library and tool to access Internet Gateway Devices"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://miniupnp.tuxfamily.org/files/miniupnpc-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d52a0afa614ad6c088cc9ddff1ae7d29c8c595ac5fdd321170a05f41e634bd1a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="miniupnpc-dev"
CLANDRO_PKG_REPLACES="miniupnpc-dev"

clandro_step_post_make_install() {
	ln -sfT upnpc-static "$CLANDRO_PREFIX/bin/upnpc"
}

clandro_step_post_massage() {
	local _EXTERNAL_IP="bin/external-ip.sh"
	if [ -f "${_EXTERNAL_IP}" ]; then
		chmod 0700 "${_EXTERNAL_IP}"
	fi
}
