CLANDRO_PKG_HOMEPAGE=https://openjdk.java.net
CLANDRO_PKG_DESCRIPTION="Java development kit and runtime"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="25.0.3"
CLANDRO_PKG_SRCURL="https://github.com/openjdk/jdk25u/archive/refs/tags/jdk-${CLANDRO_PKG_VERSION}-ga.tar.gz"
CLANDRO_PKG_SHA256=24080b39d5bb28c34d1fa738e8704db411c6fc7dac0962cc33305536b0391b9e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='25\.\d+\.\d+(?=-ga)'
CLANDRO_PKG_DEPENDS="libandroid-shmem, libandroid-spawn, libiconv, libjpeg-turbo, zlib, littlecms, alsa-plugins"
CLANDRO_PKG_BUILD_DEPENDS="cups, fontconfig, libxrandr, libxt, xorgproto, alsa-lib"
# openjdk-25-x is recommended because X11 separation is still very experimental.
CLANDRO_PKG_RECOMMENDS="ca-certificates-java, openjdk-25-x, resolv-conf"
# openjdk no longer officially supports 32-bit x86
# technically, it has been manually force-tested by the author of the openjdk-25 Termux package,
# and it does still work superficially,
# but it hasn't been just lightly disabled, it has had 30,000 lines of code deleted and that's a huge patch
# that doesn't really belong in Termux, so upstream is clear that they don't want people to use it anymore.
# https://github.com/openjdk/jdk25u/commit/ee710fec21c4e886769576c17ad6db2ab91a84b4
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_SUGGESTS="cups"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HAS_DEBUG=false
CLANDRO_PKG_HOSTBUILD=true
# enable lto
__jvm_features="link-time-opt"

clandro_step_host_build() {
	# precompiled JDK release for GNU/Linux to use as host JDK for bootstrapping
	# does not need to exactly match the CLANDRO_PKG_VERSION
	JDK_BINURL="https://download.java.net/java/GA/jdk25/bd75d5f9689641da8e1daabeccb5528b/36/GPL/openjdk-25_linux-x64_bin.tar.gz"
	JDK_BINARCHIVE="${CLANDRO_PKG_CACHEDIR}/openjdk-25_linux-x64_bin.tar.gz"
	JDK_BINSHA256=59cdcaf255add4721de38eb411d4ecfe779356b61fb671aee63c7dec78054c2b
	clandro_download "$JDK_BINURL" "$JDK_BINARCHIVE" "$JDK_BINSHA256"
	tar -xf "$JDK_BINARCHIVE" --strip-components=1 -C "$CLANDRO_PKG_HOSTBUILD_DIR"
}

clandro_step_pre_configure() {
	unset JAVA_HOME

	local patch="$CLANDRO_PKG_BUILDER_DIR/tmpdir-path-length.diff"
	local tmpdir_path="$CLANDRO_PREFIX/tmp"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		-e "s%\@CLANDRO_TMPDIR_PATH_LENGTH\@%${#tmpdir_path}%g" \
		"$patch" | patch --silent -p1

	# g1gc causes 'Illegal instruction' on 32-bit ARM after
	# https://github.com/openjdk/jdk24u/commit/0b467e902d591ae9feeec1669918d1588987cd1c
	# and LTO causes 'Segmentation fault' on 32-bit ARM after
	# https://github.com/openjdk/jdk24u/commit/85fedbf668023fd00d70ec649504c2f80e4c84bb
	# (disabling both commits is necessary,
	# if either one is disabled alone, respective crash still happens)
	if [[ "$CLANDRO_ARCH" == "arm" ]]; then
		__jvm_features="-g1gc,-link-time-opt"
	fi
}

clandro_step_configure() {
	local jdk_ldflags="-L${CLANDRO_PREFIX}/lib \
		-Wl,-rpath=$CLANDRO_PREFIX/lib/jvm/java-25-openjdk/lib \
		-Wl,-rpath=${CLANDRO_PREFIX}/lib -Wl,--enable-new-dtags"
	bash ./configure \
		--with-boot-jdk="$CLANDRO_PKG_HOSTBUILD_DIR" \
		--disable-precompiled-headers \
		--disable-warnings-as-errors \
		--enable-option-checking=fatal \
		--with-version-pre="" \
		--with-version-opt="" \
		--with-jvm-variants=server \
		--with-jvm-features="${__jvm_features}" \
		--with-debug-level=release \
		--openjdk-target=$CLANDRO_HOST_PLATFORM \
		--with-toolchain-type=clang \
		--with-extra-cflags="$CFLAGS $CPPFLAGS -DLE_STANDALONE -D__ANDROID__=1 -D__TERMUX__=1" \
		--with-extra-cxxflags="$CXXFLAGS $CPPFLAGS -DLE_STANDALONE -D__ANDROID__=1 -D__TERMUX__=1" \
		--with-extra-ldflags="${jdk_ldflags} -Wl,--as-needed -landroid-shmem -landroid-spawn" \
		--with-cups-include="$CLANDRO_PREFIX/include" \
		--with-fontconfig-include="$CLANDRO_PREFIX/include" \
		--with-freetype-include="$CLANDRO_PREFIX/include/freetype2" \
		--with-freetype-lib="$CLANDRO_PREFIX/lib" \
		--with-alsa="$CLANDRO_PREFIX" \
		--with-alsa-include="$CLANDRO_PREFIX/include/alsa" \
		--with-alsa-lib="$CLANDRO_PREFIX/lib" \
		--with-x="$CLANDRO_PREFIX/include/X11" \
		--x-includes="$CLANDRO_PREFIX/include/X11" \
		--x-libraries="$CLANDRO_PREFIX/lib" \
		--with-giflib=system \
		--with-lcms=system \
		--with-libjpeg=system \
		--with-libpng=system \
		--with-zlib=system \
		--with-vendor-name="Termux" \
		AR="$AR" \
		NM="$NM" \
		OBJCOPY="$OBJCOPY" \
		OBJDUMP="$OBJDUMP" \
		STRIP="$STRIP" \
		CXXFILT="llvm-cxxfilt" \
		BUILD_CC="$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang" \
		BUILD_CXX="$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang++" \
		BUILD_NM="$CLANDRO_HOST_LLVM_BASE_DIR/bin/llvm-nm" \
		BUILD_AR="$CLANDRO_HOST_LLVM_BASE_DIR/bin/llvm-ar" \
		BUILD_OBJCOPY="$CLANDRO_HOST_LLVM_BASE_DIR/bin/llvm-objcopy" \
		BUILD_STRIP="$CLANDRO_HOST_LLVM_BASE_DIR/bin/llvm-strip" \
		--with-jobs=$CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make() {
	cd build/linux-${CLANDRO_ARCH/i686/x86}-server-release
	make images
}

clandro_step_make_install() {
	rm -rf  $CLANDRO_PREFIX/lib/jvm/java-25-openjdk
	mkdir -p $CLANDRO_PREFIX/lib/jvm/java-25-openjdk
	cp -r build/linux-${CLANDRO_ARCH/i686/x86}-server-release/images/jdk/* \
		$CLANDRO_PREFIX/lib/jvm/java-25-openjdk/
	find $CLANDRO_PREFIX/lib/jvm/java-25-openjdk/ -name "*.debuginfo" -delete

	# Dependent projects may need JAVA_HOME.
	mkdir -p $CLANDRO_PREFIX/lib/jvm/java-25-openjdk/etc/profile.d
	echo "export JAVA_HOME=$CLANDRO_PREFIX/lib/jvm/java-25-openjdk/" > \
		$CLANDRO_PREFIX/lib/jvm/java-25-openjdk/etc/profile.d/java.sh
}

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/lib/jvm/java-25-openjdk/man/man1
	for manpage in *.1; do
		gzip "$manpage"
	done

	# Make sure that our alternatives file is up to date.
	binaries="$(find $CLANDRO_PREFIX/lib/jvm/java-25-openjdk/bin -executable -type f | xargs -I{} basename "{}" | xargs echo)"
	manpages="$(find $CLANDRO_PREFIX/lib/jvm/java-25-openjdk/man/man1 -name "*.1.gz" | xargs -I{} basename "{}" | xargs echo)"

	local failure=false
	for binary in $binaries; do
		grep -q "lib/jvm/java-25-openjdk/bin/${binary}$" "$CLANDRO_PKG_BUILDER_DIR"/openjdk-25.alternatives || {
			echo "ERROR: Missing entry for binary: $binary in openjdk-25.alternatives"
			failure=true
		}
	done

	for manpage in $manpages; do
		grep -q "lib/jvm/java-25-openjdk/man/man1/${manpage}$" "$CLANDRO_PKG_BUILDER_DIR"/openjdk-25.alternatives || {
			echo "ERROR: Missing entry for manpage: $manpage in openjdk-25.alternatives"
			failure=true
		}
	done
	if [[ "$failure" = true ]]; then
		clandro_error_exit "ERROR: openjdk-25.alternatives is not up to date, please update it."
	fi
}
