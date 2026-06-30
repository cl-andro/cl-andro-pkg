CLANDRO_PKG_HOMEPAGE=https://github.com/ntop/n2n
CLANDRO_PKG_DESCRIPTION="A light VPN software"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ntop/n2n/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=311f89d147558ae4dfb0d8f8698f5429c05a3e19a9d25cb8c85bd73d02aff834
CLANDRO_PKG_DEPENDS="libcap, libpcap, openssl, zstd"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_FORCE_CMAKE=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-miniupnp
--disable-natpmp
--enable-pcap
--enable-cap
--disable-pthread
--with-zstd
--with-openssl
"
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"

clandro_step_pre_configure() {
	autoreconf -fi
}
