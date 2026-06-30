CLANDRO_PKG_HOMEPAGE=https://fselect.rocks/
CLANDRO_PKG_DESCRIPTION="Find files with SQL-like queries"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.0"
CLANDRO_PKG_SRCURL=https://github.com/jhspetersson/fselect/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e4b2612aef1076c5f045849c90757eee222c5b7b6c94e53909b931c1ba4d7f45
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="zlib"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_rust

	# Dummy CMake toolchain file to workaround build error:
	# error: failed to run custom build command for `libz-ng-sys v1.1.15`
	# ...
	# CMake Error at /home/builder/.termux-build/_cache/cmake-3.28.3/share/cmake-3.28/Modules/Platform/Android-Determine.cmake:217 (message):
	# Android: Neither the NDK or a standalone toolchain was found.
	export TARGET_CMAKE_TOOLCHAIN_FILE="${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"
	touch "${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	rm -rf $CARGO_HOME/registry/src/*/libmimalloc-sys-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	p="libmimalloc-sys-tls.diff"
	for d in $CARGO_HOME/registry/src/*/libmimalloc-sys-*; do
		patch --silent -p1 -d ${d} < "${CLANDRO_PKG_BUILDER_DIR}/${p}"
	done

	# ld.lld: error: undefined symbol: __atomic_load_8
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi
}

clandro_step_post_make_install() {
	install -Dm700 \
		"$CLANDRO_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/fselect \
		"$CLANDRO_PREFIX"/bin/fselect
}

clandro_step_post_massage() {
	rm -rf $CARGO_HOME/registry/src/*/libmimalloc-sys-*
}
