CLANDRO_PKG_HOMEPAGE=https://ipset.netfilter.org
CLANDRO_PKG_DESCRIPTION="Administration tool for kernel IP sets"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.24"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://ipset.netfilter.org/ipset-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=fbe3424dff222c1cb5e5c34d38b64524b2217ce80226c14fdcbb13b29ea36112
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libmnl"
CLANDRO_PKG_BREAKS="ipset-dev"
CLANDRO_PKG_REPLACES="ipset-dev"
CLANDRO_PKG_BUILD_DEPENDS="libtool"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-kmod=no
"

clandro_step_pre_configure() {
	# Workaround for version script error
	LDFLAGS+=" -Wl,--undefined-version"
}
