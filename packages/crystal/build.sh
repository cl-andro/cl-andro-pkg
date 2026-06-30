CLANDRO_PKG_HOMEPAGE=https://crystal-lang.org
CLANDRO_PKG_DESCRIPTION="Fast and statically typed, compiled language with Ruby-like syntax"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@HertzDevil"
CLANDRO_PKG_VERSION="1.20.1"
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_SRCURL=git+https://github.com/crystal-lang/crystal
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libevent, libgc, libgmp, libiconv, libllvm (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION), libxml2, libyaml, openssl, pcre2, zlib"
CLANDRO_PKG_RECOMMENDS="clang, libffi, make, pkg-config"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686, x86_64"

clandro_step_make() {
	local SHARDS_VERSION=0.18.0
	local MOLINILLO_VERSION=0.2.0
	local MOLINILLO_URL=https://github.com/crystal-lang/crystal-molinillo/archive/v$MOLINILLO_VERSION.tar.gz
	local MOLINILLO_TARFILE=$CLANDRO_PKG_TMPDIR/crystal-molinillo-$MOLINILLO_VERSION.tar.gz
	local MOLINILLO_SHA256=e231cf2411a6a11a1538983c7fb52b19e650acc3338bd3cdf6fdb13d6463861a

	clandro_setup_crystal

	CC="$CC_FOR_BUILD" ANDROID_PLATFORM="$CLANDRO_PKG_API_LEVEL" LLVM_CONFIG="$CLANDRO_PREFIX/bin/llvm-config" \
		make crystal target=$CLANDRO_HOST_PLATFORM release=1 FLAGS=-Dwithout_iconv

	$CC .build/crystal.o -o .build/crystal $LDFLAGS -rdynamic \
		$("$CLANDRO_PREFIX/bin/llvm-config" --libs --system-libs --ldflags 2> /dev/null) \
		-lstdc++ -lpcre2-8 -lm -lgc -levent -ldl

	git clone --depth 1 --single-branch \
		--branch v$SHARDS_VERSION \
		https://github.com/crystal-lang/shards.git

	cd shards
	mkdir -p lib/molinillo
	clandro_download "$MOLINILLO_URL" "$MOLINILLO_TARFILE" "$MOLINILLO_SHA256"
	tar xzf "$MOLINILLO_TARFILE" --strip-components=1 -C lib/molinillo
	CC="$CC_FOR_BUILD" ANDROID_PLATFORM="$CLANDRO_PKG_API_LEVEL" \
		make SHARDS=false release=1 \
		FLAGS="--cross-compile --target $CLANDRO_HOST_PLATFORM -Dwithout_iconv"
	$CC bin/shards.o -o bin/shards $LDFLAGS -rdynamic \
		-lyaml -lpcre2-8 -lgc -levent -ldl
}

clandro_step_make_install() {
	LLVM_CONFIG="$CLANDRO_PREFIX/bin/llvm-config" make install PREFIX="$CLANDRO_PREFIX"
	cd shards && make install PREFIX="$CLANDRO_PREFIX"
}
