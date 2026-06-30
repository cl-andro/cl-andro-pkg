CLANDRO_PKG_HOMEPAGE=https://luvit.io
CLANDRO_PKG_DESCRIPTION="A project in-between luv and luvit"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Komo @mbekkomo"
CLANDRO_PKG_VERSION=1:2.15.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/luvit/luvi
CLANDRO_PKG_DEPENDS="lua51-lpeg, luajit, luv, openssl, pcre2, zlib"
CLANDRO_PKG_SUGGESTS="lit, luvit"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
	-DWithSharedLibluv=On
	-DWithOpenSSL=On
	-DWithSharedOpenSSL=On
	-DWithPCRE2=On
	-DWithSharedPCRE2=On
	-DWithLPEG=On
	-DWithSharedLPEG=On
	-DWithZLIB=On
	-DWithSharedZLIB=ON
	-DLIBLUV_INCLUDE_DIR=${CLANDRO_PREFIX}/include/luv
	-DLUAJIT_INCLUDE_DIR=${CLANDRO_PREFIX}/include/luajit-2.1
	-DLIBUV_INCLUDE_DIR=${CLANDRO_PREFIX}/include
	-DOPENSSL_INCLUDE_DIR=${CLANDRO_PREFIX}/include
	-DPCRE2_INCLUDE_DIR=${CLANDRO_PREFIX}/include
	-DZLIB_INCLUDE_DIR=${CLANDRO_PREFIX}/include
	-DLIBLUV_LIBRARIES=${CLANDRO_PREFIX}/lib/libluv.so
	-DLUAJIT_LIBRARIES=${CLANDRO_PREFIX}/lib/libluajit.so
	-DLIBUV_LIBRARIES=${CLANDRO_PREFIX}/lib/libuv.so
	-DOPENSSL_LIBRARIES=${CLANDRO_PREFIX}/lib/libssl.so;${CLANDRO_PREFIX}/lib/libcrypto.so
	-DPCRE2_LIBRARIES=${CLANDRO_PREFIX}/lib/libpcre2-8.so
	-DZLIB_LIBRARIES=${CLANDRO_PREFIX}/lib/libz.so
	-DLPEG_LIBRARIES=${CLANDRO_PREFIX}/lib/liblpeg-5.1.so
"

clandro_step_pre_configure() {
	local dlp_commit="7adf5b3" script_checksum="4b4412c4e93c3cebfc830c643a04b31108a12f10abf7489ab0a80077a1a1ccdb"

	clandro_download "https://github.com/ReFreezed/DumbLuaParser/raw/${dlp_commit}/dumbParser.lua" \
		"${CLANDRO_PKG_CACHEDIR}/dumbParser.lua" \
		"${script_checksum}"
	export LUA_PATH=";;${CLANDRO_PKG_CACHEDIR}/?.lua"

	echo "${CLANDRO_PKG_VERSION:2}" > "${CLANDRO_PKG_SRCDIR}/VERSION"
}
