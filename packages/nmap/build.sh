CLANDRO_PKG_HOMEPAGE=https://nmap.org/
CLANDRO_PKG_DESCRIPTION="Utility for network discovery and security auditing"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.99"
CLANDRO_PKG_SRCURL=https://nmap.org/dist/nmap-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=df512492ffd108e53a27a06f26d8635bbe89e0e569455dc8ffef058c035d51b2
CLANDRO_PKG_DEPENDS="libc++, lua54, libpcap, libssh2, openssl, pcre2, resolv-conf, zlib"
CLANDRO_PKG_BREAKS="nmap-ncat"
CLANDRO_PKG_REPLACES="nmap-ncat"
CLANDRO_PKG_PROVIDES="nc, ncat, netcat"
# --without-nmap-update to avoid linking against libsvn_client:
# --without-zenmap to avoid python scripts for graphical gtk frontend:
# --without-ndiff to avoid python2-using ndiff utility:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-static
--with-liblua=$CLANDRO_PREFIX
--without-nmap-update
--without-zenmap
--without-ndiff
"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		STRIP="$(command -v true)"
	fi
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_STRIP=$STRIP"
}

clandro_step_post_massage() {
	mv -v bin/ncat bin/netcat-nmap
	mv -v share/man/man1/ncat.1.gz share/man/man1/netcat-nmap.1.gz
}
