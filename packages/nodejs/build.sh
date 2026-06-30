CLANDRO_PKG_HOMEPAGE=https://nodejs.org/
CLANDRO_PKG_DESCRIPTION="Open Source, cross-platform JavaScript runtime environment"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION=25.8.2
CLANDRO_PKG_SRCURL=https://nodejs.org/dist/v${CLANDRO_PKG_VERSION}/node-v${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=3efb19e757dc59bb21632507200d2de782369d5226a68955e9372c925fdf2471
# thunder-coding: don't try to autoupdate nodejs, that thing takes 2 whole hours to build for a single arch, and requires a lot of patch updates everytime. Also I run tests everytime I update it to ensure least bugs
CLANDRO_PKG_AUTO_UPDATE=false
# Note that we do not use a shared libuv to avoid an issue with the Android
# linker, which does not use symbols of linked shared libraries when resolving
# symbols on dlopen(). See https://github.com/termux/termux-packages/issues/462.
CLANDRO_PKG_DEPENDS="libc++, openssl, c-ares, libicu, libsqlite, zlib"
CLANDRO_PKG_RECOMMENDS="npm"
CLANDRO_PKG_CONFLICTS="nodejs-lts, nodejs-current"
CLANDRO_PKG_BREAKS="nodejs-dev"
CLANDRO_PKG_REPLACES="nodejs-current, nodejs-dev"
CLANDRO_PKG_SUGGESTS="clang, make, pkg-config, python"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	# Prevent caching of host build:
	rm -Rf $CLANDRO_PKG_HOSTBUILD_DIR
}

clandro_step_host_build() {
	######
	# Do host-build of ICU, which is required for nodejs
	######
	local ICU_VERSION=78.1
	local ICU_TAR=icu4c-${ICU_VERSION}-sources.tgz
	local ICU_DOWNLOAD=https://github.com/unicode-org/icu/releases/download/release-${ICU_VERSION}/$ICU_TAR
	clandro_download \
		$ICU_DOWNLOAD\
		$CLANDRO_PKG_CACHEDIR/$ICU_TAR \
		6217f58ca39b23127605cfc6c7e0d3475fe4b0d63157011383d716cb41617886
	tar xf $CLANDRO_PKG_CACHEDIR/$ICU_TAR
	cd icu/source
	export CC="$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang"
	export CXX="$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang++"
	export LD="$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang++"
	if [ "$CLANDRO_ARCH_BITS" = 32 ]; then
		./configure --prefix $CLANDRO_PKG_HOSTBUILD_DIR/icu-installed \
			--disable-samples \
			--disable-tests \
			--build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
	else
		./configure --prefix $CLANDRO_PKG_HOSTBUILD_DIR/icu-installed \
			--disable-samples \
			--disable-tests
	fi
	make -j $CLANDRO_PKG_MAKE_PROCESSES install


	######
	# Download LLVM toolchain used by the upstream v8 project.
	# Upstream v8 uses LLVM tooling from the main branch of the LLVM project as
	# the main branch often contains bug fixes which are not released quickly to
	# stable releases. Also Ubuntu's LLVM toolchain is too old in comparison to
	# what Google uses.
	######

	# The LLVM_COMMIT, as well as the tarball of the LLVM build by Google in use
	# can be found in deps/v8/DEPS file,
	#
	# For instance, if the deps/v8/DEPS file contains:
	#
	#   'third_party/llvm-build/Release+Asserts': {
	#  'dep_type': 'gcs',
	#  'bucket': 'chromium-browser-clang',
	#  'objects': [
	#    {
	#      'object_name': 'Linux_x64/clang-llvmorg-21-init-16348-gbd809ffb-17.tar.xz',
	#      'sha256sum': 'a9f5af449672a239366199c17441427c2c4433a120cace9ffd32397e15224c64',
	#      'size_bytes': 55087424,
	#      'generation': 1754486730635359,
	#      'condition': 'host_os == "linux"',
	#    },
	#
	# then the LLVM_COMMIT is bd809ffb. The g before the hash is not part of the
	# hash, weird that they decided to include a 'g' for no reason, but 'g' isn't
	# a part of the hexadecimal characters so anyways.. Also v8 project only
	# stores the short-hash in the DEPS file, but we are using full hash here for
	# clarity. The full hash can be obtained by having a full checkout of the
	# llvm-project locally and then running `git log --format=%H -n 1` in the
	# llvm-project directory.
	#
	# Also the sha256sum is the hash of the tarball, which we can directly use
	local LLVM_TAR="clang-llvmorg-21-init-16348-gbd809ffb-17.tar.xz"
	local LLVM_TAR_HASH=a9f5af449672a239366199c17441427c2c4433a120cace9ffd32397e15224c64
	cd $CLANDRO_PKG_HOSTBUILD_DIR
	mkdir llvm-project-build
	clandro_download \
			"https://commondatastorage.googleapis.com/chromium-browser-clang/Linux_x64/${LLVM_TAR}" \
			"${CLANDRO_PKG_CACHEDIR}/${LLVM_TAR}" \
			"${LLVM_TAR_HASH}"
	tar --extract -f "${CLANDRO_PKG_CACHEDIR}/${LLVM_TAR}" --directory=llvm-project-build
}

clandro_step_pre_configure() {
	clandro_setup_ninja
}

clandro_step_configure() {
	local DEST_CPU
	if [ $CLANDRO_ARCH = "arm" ]; then
		DEST_CPU="arm"
	elif [ $CLANDRO_ARCH = "i686" ]; then
		DEST_CPU="ia32"
	elif [ $CLANDRO_ARCH = "aarch64" ]; then
		DEST_CPU="arm64"
	elif [ $CLANDRO_ARCH = "x86_64" ]; then
		DEST_CPU="x64"
	else
		clandro_error_exit "Unsupported arch '$CLANDRO_ARCH'"
	fi

	# Do not enable by default as it has severe performance degradations.
	# Causes upto 10x performance degradations
	#
	# V8 uses a lot of inlining for optimization results.
	# Although those optimizations are very much desired, during debugging it can
	# cause problems as it prevents debuggers from hooking in properly at all code
	# paths
	#
	# if [ "${CLANDRO_DEBUG_BUILD}" = "true" ]; then
	# 	CFLAGS+=" -fno-inline"
	# 	CXXFLAGS+=" -fno-inline"
	# fi

	export GYP_DEFINES="host_os=linux"
	if [ "$CLANDRO_ARCH_BITS" = "64" ]; then
		export CC_host="$CLANDRO_PKG_HOSTBUILD_DIR/llvm-project-build/bin/clang"
		export CXX_host="$CLANDRO_PKG_HOSTBUILD_DIR/llvm-project-build/bin/clang++"
		export LINK_host="$CLANDRO_PKG_HOSTBUILD_DIR/llvm-project-build/bin/clang++"
	else
		export CC_host="$CLANDRO_PKG_HOSTBUILD_DIR/llvm-project-build/bin/clang -m32"
		export CXX_host="$CLANDRO_PKG_HOSTBUILD_DIR/llvm-project-build/bin/clang++ -m32"
		export LINK_host="$CLANDRO_PKG_HOSTBUILD_DIR/llvm-project-build/bin/clang++ -m32"
	fi
	# Although without any configuration at all GYP builds both out/Release/ and out/Debug/
	# with build.ninja, it is incorrect to use the other directory as configure.py passes
	# a build_type variable to GYP which it uses to detect release/debug builds which is
	# used in some places to do some debug build specific stuff.
	# An example of such errors is the builds failing due to undefined symbols of some
	# generated source files that happen only in debug builds
	local _DEBUG=()
	if [ "${CLANDRO_DEBUG_BUILD}" = "true" ]; then
		_DEBUG+=("--debug")
	fi
	# See note above CLANDRO_PKG_DEPENDS why we do not use a shared libuv.
	# When building with ninja, build.ninja is generated for both Debug and Release builds.
	./configure \
		--prefix=$CLANDRO_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--without-npm \
		--shared-cares \
		--shared-openssl \
		--shared-sqlite \
		--shared-zlib \
		--with-intl=system-icu \
		--cross-compiling \
		--ninja \
		"${_DEBUG[@]}"

	export LD_LIBRARY_PATH=$CLANDRO_PKG_HOSTBUILD_DIR/icu-installed/lib
	sed -i \
		-e "s|\-I$CLANDRO_PREFIX/include||g" \
		-e "s|\-L$CLANDRO_PREFIX/lib||g" \
		-e "s|-licui18n||g" \
		-e "s|-licuuc||g" \
		-e "s|-licudata||g" \
		$CLANDRO_PKG_SRCDIR/out/{Release,Debug}/obj.host/node_js2c.ninja
	sed -i \
		-e "s|\-I$CLANDRO_PREFIX/include|-I$CLANDRO_PKG_HOSTBUILD_DIR/icu-installed/include|g" \
		-e "s|\-L$CLANDRO_PREFIX/lib|-L$CLANDRO_PKG_HOSTBUILD_DIR/icu-installed/lib|g" \
		-e "s|\-L$CLANDRO_PREFIX$CLANDRO_PREFIX/lib||g" \
		$(find $CLANDRO_PKG_SRCDIR/out/{Release,Debug}/obj.host -name '*.ninja')
}

clandro_step_make() {
	if [ "${CLANDRO_DEBUG_BUILD}" = "true" ]; then
		ninja -C out/Debug -j "${CLANDRO_PKG_MAKE_PROCESSES}"
	else
		ninja -C out/Release -j "${CLANDRO_PKG_MAKE_PROCESSES}"
	fi
}

clandro_step_make_install() {
	local _BUILD_DIR=out/
	if [ "${CLANDRO_DEBUG_BUILD}" = "true" ]; then
		_BUILD_DIR+="/Debug/"
	else
		_BUILD_DIR+="/Release/"
	fi
	python tools/install.py install --dest-dir="" --prefix "${CLANDRO_PREFIX}" --build-dir "$_BUILD_DIR"
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./preinst
	#!$CLANDRO_PREFIX/bin/sh
	if [ "\$#" = "3" ] && dpkg --compare-versions "\$2" le "25.3.0"; then
		echo "Starting with nodejs v25.3.0-1, npm is no longer bundled with nodejs package."
		echo "You might want to install npm package separately if you need it."
		echo "You can install it by running: pkg install npm"
		echo "It should not be needed unless you are using --no-install-recommends with apt."
	fi
	EOF
}
