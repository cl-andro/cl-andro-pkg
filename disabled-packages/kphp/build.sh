CLANDRO_PKG_HOMEPAGE=https://vkcom.github.io/kphp/
CLANDRO_PKG_DESCRIPTION="A PHP compiler"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=b1b2cec0f0e1206e1c134830ebd1f28e21bbd330
CLANDRO_PKG_VERSION=2021.12.30
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://github.com/VKCOM/kphp
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="fmt, libandroid-execinfo, libc++, libcurl, libmsgpack-cxx, libre2, libuber-h3, libucontext, libyaml-cpp, openssl-1.1, pcre, zstd"
CLANDRO_PKG_BUILD_DEPENDS="kphp-timelib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKPHP_TESTS=OFF
-DOPENSSL_INCLUDE_DIR=$CLANDRO_PREFIX/include/openssl-1.1
-DOPENSSL_LIBRARIES=$CLANDRO_PREFIX/lib/openssl-1.1
-DOPENSSL_CRYPTO_LIBRARY=$CLANDRO_PREFIX/lib/openssl-1.1/libcrypto.so.1.1
-DOPENSSL_SSL_LIBRARY=$CLANDRO_PREFIX/lib/openssl-1.1/libssl.so.1.1"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"

	CFLAGS="-I$CLANDRO_PREFIX/include/openssl-1.1 $CFLAGS"
	CPPFLAGS="-I$CLANDRO_PREFIX/include/openssl-1.1 $CPPFLAGS"
	CXXFLAGS="-I$CLANDRO_PREFIX/include/openssl-1.1 $CXXFLAGS"
	LDFLAGS="-L$CLANDRO_PREFIX/lib/openssl-1.1 -Wl,-rpath=$CLANDRO_PREFIX/lib/openssl-1.1 $LDFLAGS"
}

clandro_step_post_configure() {
	local f
	if [ "$CLANDRO_PKG_CMAKE_BUILD" == "Ninja" ]; then
		f=build.ninja
	else
		f=CMakeFiles/kphp2cpp.dir/link.txt
	fi
	sed -i -e 's/-l:libyaml-cpp\.a/-lyaml-cpp/g' \
		-e 's/-l:libre2\.a/-lre2/g' \
		$f

	local bin=$CLANDRO_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	for exe in generate_unicode_utils prepare_unicode_data; do
		$CC_FOR_BUILD $CLANDRO_PKG_SRCDIR/common/unicode/${exe//_/-}.cpp \
			-o ${bin}/${exe}
	done
	export PATH=$bin:$PATH
}
