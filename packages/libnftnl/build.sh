CLANDRO_PKG_HOMEPAGE=https://www.netfilter.org/projects/libnftnl/
CLANDRO_PKG_DESCRIPTION="Netfilter library providing interface to the nf_tables subsystem"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.1"
CLANDRO_PKG_SRCURL=https://netfilter.org/projects/libnftnl/files/libnftnl-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=607da28dba66fbdeccf8ef1395dded9077e8d19f2995f9a4d45a9c2f0bcffba8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libmnl"
CLANDRO_PKG_BREAKS="libnftnl-dev"
CLANDRO_PKG_REPLACES="libnftnl-dev"

clandro_step_pre_configure() {
	# Avoid the below errors:
	# error: version script assignment of 'LIBNFTNL_11' to symbol 'nftnl_chain_parse' failed: symbol not defined
	# error: version script assignment of 'LIBNFTNL_11' to symbol 'nftnl_chain_parse_file' failed: symbol not defined
	# error: version script assignment of 'LIBNFTNL_11' to symbol 'nftnl_set_elems_foreach' failed: symbol not defined
	# See https://bugs.gentoo.org/914710
	LDFLAGS+=" -Wl,-undefined-version"
}
