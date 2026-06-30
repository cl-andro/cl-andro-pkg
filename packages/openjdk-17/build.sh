CLANDRO_PKG_HOMEPAGE=https://openjdk.java.net
CLANDRO_PKG_DESCRIPTION="Java development kit and runtime"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="17.0.19"
CLANDRO_PKG_SRCURL=https://github.com/openjdk/jdk17u/archive/refs/tags/jdk-${CLANDRO_PKG_VERSION}-ga.tar.gz
CLANDRO_PKG_SHA256=b165f0dd120f4455904b76cf87dd9352fd23f88c2e9a33c2532fabacc3cca962
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='17\.\d+\.\d+(?=-ga)'
CLANDRO_PKG_DEPENDS="libandroid-shmem, libandroid-spawn, libiconv, libjpeg-turbo, zlib, littlecms, alsa-plugins"
CLANDRO_PKG_BUILD_DEPENDS="cups, fontconfig, libxrandr, libxt, xorgproto, alsa-lib"
# openjdk-17-x is recommended because X11 separation is still very experimental.
CLANDRO_PKG_RECOMMENDS="ca-certificates-java, openjdk-17-x, resolv-conf"
CLANDRO_PKG_SUGGESTS="cups"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HAS_DEBUG=false
# enable lto, but do not explicitly enable zgc or shenandoahgc because they
# are automatically enabled for x86, but are not supported for arm.
__jvm_features="link-time-opt"

clandro_step_pre_configure() {
	unset JAVA_HOME

	local patch="$CLANDRO_PKG_BUILDER_DIR/tmpdir-path-length.diff"
	local tmpdir_path="$CLANDRO_PREFIX/tmp"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		-e "s%\@CLANDRO_TMPDIR_PATH_LENGTH\@%${#tmpdir_path}%g" \
		"$patch" | patch --silent -p1
}

clandro_step_configure() {
	local jdk_ldflags="-L${CLANDRO_PREFIX}/lib \
		-Wl,-rpath=$CLANDRO_PREFIX/lib/jvm/java-17-openjdk/lib \
		-Wl,-rpath=${CLANDRO_PREFIX}/lib -Wl,--enable-new-dtags"
	bash ./configure \
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
		--with-extra-ldflags="${jdk_ldflags} -Wl,--as-needed -landroid-shmem -landroid-spawn -liconv" \
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
	rm -rf $CLANDRO_PREFIX/lib/jvm/java-17-openjdk
	mkdir -p $CLANDRO_PREFIX/lib/jvm/java-17-openjdk
	cp -r build/linux-${CLANDRO_ARCH/i686/x86}-server-release/images/jdk/* \
		$CLANDRO_PREFIX/lib/jvm/java-17-openjdk/
	find $CLANDRO_PREFIX/lib/jvm/java-17-openjdk/ -name "*.debuginfo" -delete

	# Dependent projects may need JAVA_HOME.
	mkdir -p $CLANDRO_PREFIX/lib/jvm/java-17-openjdk/etc/profile.d
	echo "export JAVA_HOME=$CLANDRO_PREFIX/lib/jvm/java-17-openjdk/" > \
		$CLANDRO_PREFIX/lib/jvm/java-17-openjdk/etc/profile.d/java.sh
}

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/lib/jvm/java-17-openjdk/man/man1
	for manpage in *.1; do
		gzip "$manpage"
	done

	# Make sure that our alternatives file is up to date.
	binaries="$(find $CLANDRO_PREFIX/lib/jvm/java-17-openjdk/bin -executable -type f | xargs -I{} basename "{}" | xargs echo)"
	manpages="$(find $CLANDRO_PREFIX/lib/jvm/java-17-openjdk/man/man1 -name "*.1.gz" | xargs -I{} basename "{}" | xargs echo)"

	local failure=false
	for binary in $binaries; do
		grep -q "lib/jvm/java-17-openjdk/bin/${binary}$" "$CLANDRO_PKG_BUILDER_DIR"/openjdk-17.alternatives || {
			echo "ERROR: Missing entry for binary: $binary in openjdk-17.alternatives"
			failure=true
		}
	done
	for manpage in $manpages; do
		grep -q "lib/jvm/java-17-openjdk/man/man1/${manpage}$" "$CLANDRO_PKG_BUILDER_DIR"/openjdk-17.alternatives || {
			echo "ERROR: Missing entry for manpage: $manpage in openjdk-17.alternatives"
			failure=true
		}
	done
	if [[ "$failure" = true ]]; then
		clandro_error_exit "openjdk-17.alternatives is not up to date, please update it."
	fi
}

clandro_step_create_debscripts() {
	# For older versions of openjdk-17 and openjdk-21, we used to provide different alternatives for each binary and manpage.
	# This script removes those alternatives if the user is upgrading from an older version.
	#
	# Using slaves for all binaries and manpages makes it much easier to switch between different versions of openjdk.
	local old_alternatives=(
		java-profile
		jar
		jarsigner
		java
		javac
		javadoc
		javap
		jcmd
		jconsole
		jdb
		jdeprscan
		jdeps
		jfr
		jhsdb
		jimage
		jinfo
		jlink
		jmap
		jmod
		jpackage
		jps
		jrunscript
		jshell
		jstack
		jstat
		jstatd
		jwebserver
		keytool
		rmiregistry
		serialver
		jar.1.gz
		jarsigner.1.gz
		java.1.gz
		javac.1.gz
		javadoc.1.gz
		javap.1.gz
		jcmd.1.gz
		jconsole.1.gz
		jdb.1.gz
		jdeprscan.1.gz
		jdeps.1.gz
		jfr.1.gz
		jhsdb.1.gz
		jinfo.1.gz
		jlink.1.gz
		jmap.1.gz
		jmod.1.gz
		jpackage.1.gz
		jps.1.gz
		jrunscript.1.gz
		jshell.1.gz
		jstack.1.gz
		jstat.1.gz
		jstatd.1.gz
		jwebserver.1.gz
		keytool.1.gz
		rmiregistry.1.gz
		serialver.1.gz
	)
	# For older versions
	echo 'if [ "$#" = "3" ] && dpkg --compare-versions "$2" le "17.0.15-1"; then' > ./preinst
	echo '  echo "Removing older alternatives for openjdk-21 and openjdk-17"' >> ./preinst
	echo '  echo "This may take a while if mandoc package is installed, please wait..."' >> ./preinst
	echo '  echo "Newer versions of openjdk-21 and openjdk-17 change how alternatives are handled."' >> ./preinst
	echo '  echo "Instead of having different alternatives for each manpage and binary, now you can switch java versions much easily using \"update-alternatives --config java\""' >> ./preinst
	echo '  echo "This should switch all java binaries, manpages, and bash profile for java in a single command instead of switching everything manually"' >> ./preinst
	for alternative in "${old_alternatives[@]}"; do
		echo "  update-alternatives --remove-all ${alternative} || :" >> ./preinst
	done
	echo 'fi' >> ./preinst
}
