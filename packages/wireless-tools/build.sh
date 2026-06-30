# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://hewlettpackard.github.io/wireless-tools/Tools
CLANDRO_PKG_DESCRIPTION="A set of tools allowing to manipulate the Wireless Extensions"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=30pre9
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://hewlettpackard.github.io/wireless-tools/wireless_tools.30.pre9.tar.gz
CLANDRO_PKG_SHA256=abd9c5c98abf1fdd11892ac2f8a56737544fe101e1be27c6241a564948f34c63
CLANDRO_PKG_BREAKS="wireless-tools-dev"
CLANDRO_PKG_REPLACES="wireless-tools-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make () {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS $CPPFLAGS -fPIE -pie" \
		LDFLAGS="$LDFLAGS -fPIE -pie" \
		PREFIX="${CLANDRO_PREFIX}"
}
