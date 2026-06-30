CLANDRO_PKG_HOMEPAGE=https://taskwarrior.org
CLANDRO_PKG_DESCRIPTION="Utility for managing your TODO list"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v${CLANDRO_PKG_VERSION}/task-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d302761fcd1268e4a5a545613a2b68c61abd50c0bcaade3b3e68d728dd02e716
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libc++, libgnutls, libuuid"
CLANDRO_PKG_CMAKE_BUILD="Unix Makefiles"

clandro_step_pre_configure() {
	clandro_setup_rust
	cargo install --force --locked bindgen-cli

	CXXFLAGS+=" -Wno-c++11-narrowing"
	LDFLAGS+=" -landroid-glob"
	export ANDROID_STANDALONE_TOOLCHAIN="$CLANDRO_STANDALONE_TOOLCHAIN"
	export CARGO_TARGET_$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)_RUSTFLAGS+=" -C linker=$(command -v $CC)"

	export CMAKE_POLICY_VERSION_MINIMUM=3.5
	export BINDGEN_EXTRA_CLANG_ARGS="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot"
	case "${CLANDRO_ARCH}" in
	arm) BINDGEN_EXTRA_CLANG_ARGS+=" --target=arm-linux-androideabi" ;;
	*) BINDGEN_EXTRA_CLANG_ARGS+=" --target=${CLANDRO_ARCH}-linux-android" ;;
	esac

	if [ "$CLANDRO_ARCH" = "arm" ]; then
		# See https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_ARM_MODE.html
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_ANDROID_ARM_MODE=ON"
	fi

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/aws-lc-sys \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/aws-lc-sys-cmake-system-version.diff"
	local dir="vendor/aws-lc-sys"
	echo "Applying patch: $patch"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PKG_API_LEVEL\@%${CLANDRO_PKG_API_LEVEL}%g" \
		"$patch" | patch --silent -p1 -d "${dir}"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'aws-lc-sys = { path = "./vendor/aws-lc-sys" }' >> Cargo.toml
}

clandro_step_post_make_install() {
	install -Dm600 -T "$CLANDRO_PKG_SRCDIR"/scripts/bash/task.sh \
		$CLANDRO_PREFIX/share/bash-completion/completions/task
	install -Dm600 -t $CLANDRO_PREFIX/share/fish/vendor_completions.d \
		"$CLANDRO_PKG_SRCDIR"/scripts/fish/task.fish
}
