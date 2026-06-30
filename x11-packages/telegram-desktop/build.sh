CLANDRO_PKG_HOMEPAGE=https://desktop.telegram.org/
CLANDRO_PKG_DESCRIPTION="Telegram Desktop Client"
# LICENSE: Modified GPL-2.0
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LEGAL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.8.0"
CLANDRO_PKG_SRCURL="https://github.com/telegramdesktop/tdesktop/releases/download/v$CLANDRO_PKG_VERSION/tdesktop-$CLANDRO_PKG_VERSION-full.tar.gz"
CLANDRO_PKG_SHA256=0969f58f570f5cf8c9279affa9665eab07aa88e29d257766ccbd3373e5cd6c56
CLANDRO_PKG_DEPENDS="abseil-cpp, boost, ffmpeg, glib, hicolor-icon-theme, hunspell, kf6-kcoreaddons, libandroid-shmem, libc++, libdispatch, libdrm, libjxl, liblz4, libminizip, protobuf, librnnoise, libsigc++-3.0, libx11, libxcomposite, libxdamage, libxrandr, libxtst, openal-soft, opengl, openh264, openssl, pipewire, pulseaudio, qt6-qtbase, qt6-qtimageformats, qt6-qtsvg, xxhash, zlib"
CLANDRO_PKG_BUILD_DEPENDS="ada, aosp-libs, boost-headers, glib-cross, qt6-qtbase-cross-tools"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_AUTO_UPDATE=true

# The API_KEY and API_HASH is taken from the snap build of telegram-desktop.
# See also:
# https://github.com/telegramdesktop/tdesktop/issues/17435
# https://github.com/telegramdesktop/tdesktop/blob/8fab9167beb2407c1153930ed03a4badd0c2b59f/snap/snapcraft.yaml#L87-L88
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_CXX_SCAN_FOR_MODULES=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DCMAKE_VERBOSE_MAKEFILE=ON
-DDESKTOP_APP_DISABLE_JEMALLOC=ON
-DDESKTOP_APP_DISABLE_AUTOUPDATE=ON
-DTDESKTOP_API_ID=611335
-DTDESKTOP_API_HASH=d524b414d21f4d37f08684c1df41ac9c
"

__tg_owt_fetch_source() {
	local _commit=$(CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR bash $CLANDRO_PKG_BUILDER_DIR/get_tg_owt_commit.sh)
	if [ ! -d "$CLANDRO_PKG_CACHEDIR/tg_owt-$_commit" ]; then
		pushd $CLANDRO_PKG_CACHEDIR
		rm -rf tg_owt-tmp
		git init tg_owt-tmp
		pushd tg_owt-tmp
		git remote add origin https://github.com/desktop-app/tg_owt.git
		git fetch --depth=1 origin $_commit
		git reset --hard FETCH_HEAD
		git submodule update --init --recursive --depth=1
		rm -rf .git
		popd # tg_owt
		mv tg_owt-tmp tg_owt-$_commit
		popd # $CLANDRO_PKG_CACHEDIR

	fi
	rm -rf $CLANDRO_PKG_SRCDIR/tg_owt
	mkdir -p $CLANDRO_PKG_SRCDIR/tg_owt
	cp -Rf $CLANDRO_PKG_CACHEDIR/tg_owt-$_commit/* $CLANDRO_PKG_SRCDIR/tg_owt/
}

__libtd_fetch_source() {
	local _commit=$(CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR bash $CLANDRO_PKG_BUILDER_DIR/get_libtd_commit.sh)
	if [ ! -d "$CLANDRO_PKG_CACHEDIR/libtd-$_commit" ]; then
		pushd $CLANDRO_PKG_CACHEDIR
		rm -rf libtd-tmp
		git init libtd-tmp
		pushd libtd-tmp
		git remote add origin https://github.com/tdlib/td.git
		git fetch --depth=1 origin $_commit
		git reset --hard FETCH_HEAD
		git submodule update --init --recursive --depth=1
		rm -rf .git
		popd # libtd
		mv libtd-tmp libtd-$_commit
		popd # $CLANDRO_PKG_CACHEDIR

	fi
	rm -rf $CLANDRO_PKG_SRCDIR/libtd
	mkdir -p $CLANDRO_PKG_SRCDIR/libtd
	cp -Rf $CLANDRO_PKG_CACHEDIR/libtd-$_commit/* $CLANDRO_PKG_SRCDIR/libtd/
}

clandro_step_post_get_source() {
	__tg_owt_fetch_source
	__libtd_fetch_source
}

__cppgir_build() {
	clandro_setup_cmake

	pushd $CLANDRO_PKG_HOSTBUILD_DIR
	git clone https://github.com/scipy/boost-headers-only
	mkdir -p cppgir-host-build
	pushd cppgir-host-build
	local _extra_args=""
	if [ "$CLANDRO_ON_DEVICE_BUILD" = true ]; then
		_extra_args+=" -DGIR_DEFAULT_DIRS=$CLANDRO_PREFIX/share"
	fi
	cmake \
		-DCMAKE_CXX_FLAGS="-DBOOST_NO_CXX98_FUNCTION_BASE=1" \
		-DCMAKE_INSTALL_PREFIX=$CLANDRO_PKG_HOSTBUILD_DIR/cppgir-host-build/prefix \
		-DBoost_INCLUDE_DIR=$CLANDRO_PKG_HOSTBUILD_DIR/boost-headers-only \
		$_extra_args \
		$CLANDRO_PKG_SRCDIR/cmake/external/glib/cppgir
	make -j $CLANDRO_PKG_MAKE_PROCESSES cppgir
	make install
	popd # cppgir-host-build
	popd # $CLANDRO_PKG_HOSTBUILD_DIR
}

__libtd_host_build() {
	clandro_setup_cmake

	mkdir -p $CLANDRO_PKG_TMPDIR/host-pkg-config
	ln -sf /usr/bin/pkg-config $CLANDRO_PKG_TMPDIR/host-pkg-config/

	pushd $CLANDRO_PKG_HOSTBUILD_DIR
	rm -rf libtd-host-build
	mkdir -p libtd-host-build
	pushd libtd-host-build
	(set +e +u
	export PATH="$CLANDRO_PKG_TMPDIR/host-pkg-config:$PATH"
	unset PREFIX prefix CPPFLAGS CC CFLAGS CXX CXXFLAGS LD LDFLAGS PKGCONFIG PKG_CONFIG PKG_CONFIG_DIR PKG_CONFIG_LIBDIR
	cmake \
		-DCMAKE_BUILD_TYPE=Release \
		$CLANDRO_PKG_SRCDIR/libtd
	make -j $CLANDRO_PKG_MAKE_PROCESSES prepare_cross_compiling
	)
	popd # libtd-host-build
	popd # $CLANDRO_PKG_HOSTBUILD_DIR
}

CLANDRO_PKG_HOSTBUILD=true
clandro_step_host_build() {
	# Compile cppgir
	__cppgir_build
}

__tg_owt_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	local _TG_OWT_BUILD_DIR="$CLANDRO_PKG_BUILDDIR"/tg_owt-build
	if [ -f "$_TG_OWT_BUILD_DIR"/.tg_owt-built ]; then
		cd "$_TG_OWT_BUILD_DIR"
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES install
		cd "$CLANDRO_PKG_BUILDDIR"
		return
	fi

	# Backup vars
	local __old_srcdir="$CLANDRO_PKG_SRCDIR"
	local __old_builddir="$CLANDRO_PKG_BUILDDIR"
	local __old_conf_args="$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR"/tg_owt
	CLANDRO_PKG_BUILDDIR="$_TG_OWT_BUILD_DIR"
	# Enabling TG_OWT_USE_PIPEWIRE will pick up `libgbm` which doesn't work on Termux
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_SHARED_LIBS=OFF
-DBUILD_STATIC_LIBS=ON
-DTG_OWT_USE_PIPEWIRE=OFF
"

	# Configure
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure_cmake

	# Cross-compile & install
	cd "$CLANDRO_PKG_BUILDDIR"
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES install

	# Recover vars
	CLANDRO_PKG_SRCDIR="$__old_srcdir"
	CLANDRO_PKG_BUILDDIR="$__old_builddir"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="$__old_conf_args"

	# Mark as built
	mkdir -p "$_TG_OWT_BUILD_DIR"
	touch -f "$_TG_OWT_BUILD_DIR"/.tg_owt-built
}

__libtd_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	local _LIBTD_BUILD_DIR="$CLANDRO_PKG_BUILDDIR"/libtd-build
	if [ -f "$_LIBTD_BUILD_DIR"/.libtd-built ]; then
		cd "$_LIBTD_BUILD_DIR"
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES install
		cd "$CLANDRO_PKG_BUILDDIR"
		return
	fi

	# Prepare cross-compiling for libtd
	if [ "$CLANDRO_ON_DEVICE_BUILD" = false ]; then
		__libtd_host_build
	fi

	# Backup vars
	local __old_srcdir="$CLANDRO_PKG_SRCDIR"
	local __old_builddir="$CLANDRO_PKG_BUILDDIR"
	local __old_conf_args="$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR"/libtd
	CLANDRO_PKG_BUILDDIR="$_LIBTD_BUILD_DIR"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_SHARED_LIBS=OFF
-DBUILD_STATIC_LIBS=ON
-DTD_INSTALL_SHARED_LIBRARIES=OFF
-DTD_INSTALL_STATIC_LIBRARIES=ON
-DTD_E2E_ONLY=ON
-DTDE2E_INSTALL_INCLUDES=ON
"

	if [ "$CLANDRO_ON_DEVICE_BUILD" = true ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_CROSSCOMPILING=FALSE"
	fi

	# Configure
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure_cmake

	# Cross-compile & install
	cd "$CLANDRO_PKG_BUILDDIR"
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES install

	# Recover vars
	CLANDRO_PKG_SRCDIR="$__old_srcdir"
	CLANDRO_PKG_BUILDDIR="$__old_builddir"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="$__old_conf_args"

	# Mark as built
	mkdir -p "$_LIBTD_BUILD_DIR"
	touch -f "$_LIBTD_BUILD_DIR"/.libtd-built
}

clandro_step_configure() {
	__tg_owt_build
	__libtd_build

	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_protobuf
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPREBUILT_CPPGIR=$CLANDRO_PKG_HOSTBUILD_DIR/cppgir-host-build/prefix/bin/cppgir"
	if [ "$CLANDRO_ON_DEVICE_BUILD" = false ]; then
		clandro_setup_proot

		CPPFLAGS+=" -DG_VA_COPY_AS_ARRAY=0"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPROTOBUF_PROTOC_EXECUTABLE=$(command -v protoc)"

		mkdir -p "$CLANDRO_PKG_TMPDIR/bin"
		local _type
		for _type in emoji lang style; do
			cat <<-EOF > $CLANDRO_PKG_TMPDIR/bin/codegen_$_type
				#!$(command -v sh)
				exec $(command -v termux-proot-run) $CLANDRO_PKG_BUILDDIR/Telegram/codegen/codegen/$_type/codegen_$_type "\$@"
			EOF
			chmod +x $CLANDRO_PKG_TMPDIR/bin/codegen_$_type
		done
		export PATH="$CLANDRO_PKG_TMPDIR/bin:$PATH"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_CROSSCOMPILING=FALSE"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_AUTOMOC_EXECUTABLE=$CLANDRO_PREFIX/lib/qt6/moc"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_AUTORCC_EXECUTABLE=$CLANDRO_PREFIX/lib/qt6/rcc"
	fi

	LDFLAGS+=" -landroid-shmem"

	cd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure_cmake
}
