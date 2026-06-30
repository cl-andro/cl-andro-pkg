CLANDRO_PKG_HOMEPAGE=https://github.com/termux/termux-packages
CLANDRO_PKG_DESCRIPTION="Fake ldd command"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_DEPENDS="bash, binutils"
CLANDRO_PKG_CONFLICTS="binutils (<< 2.39-1)"

clandro_step_make_install() {
	local _READELF="$CLANDRO_PREFIX/bin/greadelf"

	local ldd="$CLANDRO_PREFIX/bin/ldd"
	mkdir -p "$(dirname "${ldd}")"
	rm -rf "${ldd}"
	sed "$CLANDRO_PKG_BUILDER_DIR/ldd.in" \
		-e "s|@ARCH_BITS@|${CLANDRO_ARCH_BITS}|g" \
		-e "s|@READELF@|${_READELF}|g" \
		> "${ldd}"
	chmod 0700 "${ldd}"
}
