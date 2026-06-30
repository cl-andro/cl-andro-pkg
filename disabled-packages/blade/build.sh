CLANDRO_PKG_HOMEPAGE=https://bladelang.com/
CLANDRO_PKG_DESCRIPTION="A simple, fast, clean and dynamic language"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.87"
CLANDRO_PKG_SRCURL=https://github.com/blade-lang/blade/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7a438f126eed74077d6112b89c9d890a8cc0a3affbccde0b023ad43639fed4de
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="libgd, libcurl, openssl"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	sed -i '/add_subdirectory(imagine)/d' $CLANDRO_PKG_SRCDIR/packages/CMakeLists.txt
	clandro_setup_cmake
	cmake $CLANDRO_PKG_SRCDIR
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	echo "add_subdirectory(imagine)" >> $CLANDRO_PKG_SRCDIR/packages/CMakeLists.txt
}

clandro_step_pre_configure() {
	PATH=$CLANDRO_PKG_HOSTBUILD_DIR/blade:$PATH
	export LD_LIBRARY_PATH=$CLANDRO_PKG_HOSTBUILD_DIR/blade
}

clandro_step_make_install() {
	pushd blade
	install -Dm700 -t $CLANDRO_PREFIX/bin blade
	install -Dm600 -t $CLANDRO_PREFIX/lib libblade.so
	local sharedir=$CLANDRO_PREFIX/share/blade
	mkdir -p $sharedir
	cp -r $CLANDRO_PKG_SRCDIR/benchmarks $CLANDRO_PKG_BUILDDIR/blade/includes $CLANDRO_PKG_SRCDIR/libs $CLANDRO_PKG_SRCDIR/tests $sharedir/
	popd
}
