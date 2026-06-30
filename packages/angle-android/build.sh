CLANDRO_PKG_HOMEPAGE=https://chromium.googlesource.com/angle/angle
CLANDRO_PKG_DESCRIPTION="A conformant OpenGL ES implementation for Windows, Mac, Linux, iOS and Android"
CLANDRO_PKG_LICENSE="BSD 3-Clause, Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT_DATE=2025.02.23
_COMMIT=f09a19cebdaf04bddcd3101e9783207cb5cf3e13
_COMMIT_POSISION=24923
CLANDRO_PKG_SRCURL=git+https://chromium.googlesource.com/angle/angle
CLANDRO_PKG_VERSION="2.1.$_COMMIT_POSISION-${_COMMIT:0:8}"
CLANDRO_PKG_REVISION=2

CLANDRO_PKG_HOSTBUILD=true

clandro_step_get_source() {
	# Check whether we need to get source
	if [ -f "$CLANDRO_PKG_CACHEDIR/.angle-source-fetched" ]; then
		local _fetched_source_version=$(cat $CLANDRO_PKG_CACHEDIR/.angle-source-fetched)
		if [ "$_fetched_source_version" = "$CLANDRO_PKG_VERSION" ]; then
			echo "[INFO]: Use pre-fetched source (version $_fetched_source_version)."
			ln -sfr $CLANDRO_PKG_CACHEDIR/tmp-checkout/angle $CLANDRO_PKG_SRCDIR
			return
		fi
	fi

	# Fetch depot_tools
	if [ ! -f "$CLANDRO_PKG_CACHEDIR/.depot_tools-fetched" ];then
		git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git $CLANDRO_PKG_CACHEDIR/depot_tools
		touch "$CLANDRO_PKG_CACHEDIR/.depot_tools-fetched"
	fi
	export PATH="$CLANDRO_PKG_CACHEDIR/depot_tools:$PATH"
	$CLANDRO_PKG_CACHEDIR/depot_tools/ensure_bootstrap
	export DEPOT_TOOLS_UPDATE=0

	# Get source
	rm -rf "$CLANDRO_PKG_CACHEDIR/tmp-checkout"
	mkdir -p "$CLANDRO_PKG_CACHEDIR/tmp-checkout"
	pushd "$CLANDRO_PKG_CACHEDIR/tmp-checkout"
	gclient config --verbose --unmanaged ${CLANDRO_PKG_SRCURL#git+}
	echo "" >> .gclient
	echo 'target_os = ["android"]' >> .gclient
	gclient sync --verbose --revision $_COMMIT

	# Check commit posision
	cd angle
	local _real_commit_posision="$(git rev-list HEAD --count)"
	if [ "$_real_commit_posision" != "$_COMMIT_POSISION" ]; then
		clandro_error_exit "Please update commit posision. Expected: $_COMMIT_POSISION, current: $_real_commit_posision."
	fi
	popd

	echo "$CLANDRO_PKG_VERSION" > "$CLANDRO_PKG_CACHEDIR/.angle-source-fetched"
	ln -sfr $CLANDRO_PKG_CACHEDIR/tmp-checkout/angle $CLANDRO_PKG_SRCDIR
}

clandro_step_host_build() {
	cd $CLANDRO_PKG_HOSTBUILD_DIR

	clandro_setup_ninja
	export PATH="$CLANDRO_PKG_CACHEDIR/depot_tools:$PATH"
	export DEPOT_TOOLS_UPDATE=0

	local _target_os=
	if [ "$CLANDRO_ARCH" = "aarch64" ] || [ "$CLANDRO_ARCH" = "arm" ]; then
		_target_os="arm64"
	elif [ "$CLANDRO_ARCH" = "x86_64" ] || [ "$CLANDRO_ARCH" = "i686" ]; then
		_target_os="x64"
	else
		clandro_error_exit "Unsupported arch: $CLANDRO_ARCH"
	fi

	# Build with Android's GL
	mkdir -p out/android
	sed -e"s|@TARGET_OS@|$_target_os|g" \
		-e "s|@ENABLE_GL@|true|g" \
		-e "s|@ENABLE_VULKAN@|false|g" \
		-e "s|@USE_VULKAN_NULL@|false|g" \
		-e "s|@CLANDRO_PKG_API_LEVEL@|$CLANDRO_PKG_API_LEVEL|g" \
		$CLANDRO_PKG_BUILDER_DIR/args.gn.in > out/android/args.gn
	pushd $CLANDRO_PKG_SRCDIR
	gn gen $CLANDRO_PKG_HOSTBUILD_DIR/out/android --export-compile-commands
	popd
	ninja -C out/android
	mkdir -p build/gl
	cp out/android/apks/AngleLibraries.apk build/gl/
	pushd build/gl
	unzip AngleLibraries.apk
	popd

	# Build with Android's Vulkan
	mkdir -p out/android
	sed -e"s|@TARGET_OS@|$_target_os|g" \
		-e "s|@ENABLE_GL@|false|g" \
		-e "s|@ENABLE_VULKAN@|true|g" \
		-e "s|@USE_VULKAN_NULL@|false|g" \
		-e "s|@CLANDRO_PKG_API_LEVEL@|$CLANDRO_PKG_API_LEVEL|g" \
		$CLANDRO_PKG_BUILDER_DIR/args.gn.in > out/android/args.gn
	pushd $CLANDRO_PKG_SRCDIR
	gn gen $CLANDRO_PKG_HOSTBUILD_DIR/out/android --export-compile-commands
	popd
	ninja -C out/android
	mkdir -p build/vulkan
	cp out/android/apks/AngleLibraries.apk build/vulkan/
	pushd build/vulkan
	unzip AngleLibraries.apk
	popd

	# Build with Android's Vulkan null display
	mkdir -p out/android
	sed -e "s|@TARGET_OS@|$_target_os|g" \
		-e "s|@ENABLE_GL@|false|g" \
		-e "s|@ENABLE_VULKAN@|true|g" \
		-e "s|@USE_VULKAN_NULL@|true|g" \
		-e "s|@CLANDRO_PKG_API_LEVEL@|$CLANDRO_PKG_API_LEVEL|g" \
		$CLANDRO_PKG_BUILDER_DIR/args.gn.in > out/android/args.gn
	pushd $CLANDRO_PKG_SRCDIR
	gn gen $CLANDRO_PKG_HOSTBUILD_DIR/out/android --export-compile-commands
	popd
	ninja -C out/android
	mkdir -p build/vulkan-null
	cp out/android/apks/AngleLibraries.apk build/vulkan-null/
	pushd build/vulkan-null
	unzip AngleLibraries.apk
	popd
}

clandro_step_configure() {
	# Remove this marker all the time, as this package is architecture-specific
	rm -rf $CLANDRO_HOSTBUILD_MARKER
}

clandro_step_configure() {
	:
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	local _lib_dir=
	if [ "$CLANDRO_ARCH" = "arm" ]; then
		_lib_dir="armeabi-v7a"
	elif [ "$CLANDRO_ARCH" = "i686" ]; then
		_lib_dir="x86"
	elif [ "$CLANDRO_ARCH" = "x86_64" ]; then
		_lib_dir="x86_64"
	elif [ "$CLANDRO_ARCH" = "aarch64" ]; then
		_lib_dir="arm64-v8a"
	else
		clandro_error_exit "Unsupported arch: $CLANDRO_ARCH"
	fi

	local _type
	for _type in gl vulkan vulkan-null; do
		mkdir -p $CLANDRO_PREFIX/opt/angle-android/$_type
		cp -v $CLANDRO_PKG_HOSTBUILD_DIR/build/$_type/lib/$_lib_dir/*.so $CLANDRO_PREFIX/opt/angle-android/$_type/
	done
}
