CLANDRO_PKG_HOMEPAGE=https://www.polyml.org/
CLANDRO_PKG_DESCRIPTION="A Standard ML implementation"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.9.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/polyml/polyml/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=5cf5f77767568c25cf880acc2d0a32ee3d399e935475ab1626e8192fc3b07390
CLANDRO_PKG_AUTO_UPDATE=true
# this package needs its libpolymain.a to run its 'polyc' command
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_DEPENDS="libandroid-posix-semaphore, libc++, libffi, libgmp"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-pic
--disable-native-codegeneration
"

clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	local CLANDRO_ORIG_PATH="$PATH"
	mkdir -p native
	pushd native
	export PATH="$(pwd):$CLANDRO_ORIG_PATH"
	$CLANDRO_PKG_SRCDIR/configure \
		CC="gcc -m${CLANDRO_ARCH_BITS}" CXX="g++ -m${CLANDRO_ARCH_BITS}" \
		--prefix=$_PREFIX_FOR_BUILD \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	sed -i -e 's/^\(#define HOSTARCHITECTURE\)_X32 1/\1_X86 1/g' config.h
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
	popd

	local arch
	case "$CLANDRO_ARCH" in
		aarch64 )
			arch=AARCH64 ;;
		arm )
			arch=ARM ;;
		x86_64 )
			arch=X86_64 ;;
		i686 )
			arch=X86 ;;
		* )
			echo "ERROR: Unknown architecture: $CLANDRO_ARCH"
			return 1 ;;
	esac

	mkdir -p cross
	pushd cross
	export PATH="$_PREFIX_FOR_BUILD/bin:$CLANDRO_ORIG_PATH"
	$CLANDRO_PKG_SRCDIR/configure \
		CC="gcc -m${CLANDRO_ARCH_BITS}" CXX="g++ -m${CLANDRO_ARCH_BITS}" \
		--prefix=$(pwd) \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	sed -i -e '/^#define HOSTARCHITECTURE_/d' config.h
	echo >> config.h
	echo "#define HOSTARCHITECTURE_${arch} 1" >> config.h
	make -j $CLANDRO_PKG_MAKE_PROCESSES -C libpolyml libpolyml.la
	make -j $CLANDRO_PKG_MAKE_PROCESSES polyimport
	make -j $CLANDRO_PKG_MAKE_PROCESSES -C libpolymain libpolymain.la
	make -j $CLANDRO_PKG_MAKE_PROCESSES poly
	popd
}

clandro_step_pre_configure() {
	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/cross:$PATH"
	_NEED_DUMMY_LIBSTDCXX_SO=
	_LIBSTDCXX_SO=$CLANDRO_PREFIX/lib/libstdc++.so
	if [ ! -e $_LIBSTDCXX_SO ]; then
		_NEED_DUMMY_LIBSTDCXX_SO=true
		echo 'INPUT(-lc++_shared)' > $_LIBSTDCXX_SO
	fi

	LDFLAGS+=" -landroid-posix-semaphore"
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}

clandro_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBSTDCXX_SO ]; then
		rm -f $_LIBSTDCXX_SO
	fi
}
