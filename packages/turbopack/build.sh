CLANDRO_PKG_HOMEPAGE=https://nextjs.org/
CLANDRO_PKG_DESCRIPTION="Rust-based incremental compilation engine and bundler for Next.js"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_VERSION="16.2.5"
CLANDRO_PKG_SRCURL=https://github.com/vercel/next.js/archive/refs/tags/v${CLANDRO_PKG_VERSION//\~/-}.tar.gz
CLANDRO_PKG_SHA256=b3ec707ac9af1fb3125f3c9b801dbfccf37d094c6ec5f3ddf4e2c7dde9e53ded
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_DEPENDS="ca-certificates"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag

clandro_step_pre_configure() {
	export ANDROID_NDK_LATEST_HOME="${CLANDRO_STANDALONE_TOOLCHAIN}"
}

clandro_step_make() {
	export RUSTC_BOOTSTRAP=1
	local RUST_TARGET
	case "$CLANDRO_ARCH" in
		aarch64) RUST_TARGET="aarch64-linux-android" ;;
		x86_64)RUST_TARGET="x86_64-linux-android" ;;
	esac
	clandro_setup_rust
	clandro_setup_nodejs
	export RUSTFLAGS="--cfg tokio_unstable"
	local ENV_PREFIX=$(echo "$RUST_TARGET" | tr '[:lower:]-' '[:upper:]_')
	if [ "$CLANDRO_ARCH" == "aarch64" ]; then
		export RUSTFLAGS="$RUSTFLAGS -Zshare-generics=y -Csymbol-mangling-version=v0"
		npm i -g "@napi-rs/cli@2.18.4" # Hardcoded NAPI_CLI_VERSION from workflow
	else
		export "CARGO_TARGET_${ENV_PREFIX}_LINKER"="$CC"
		export "CC_${RUST_TARGET//-/_}"="$CC"
	fi
	npx pnpm install
	cd packages/next-swc
	npx pnpm run build-native-release --target "$RUST_TARGET"
}

clandro_step_make_install() {
	cd packages/next-swc
	ls -l native
	local NAPI_ARCH
	case "$CLANDRO_ARCH" in
		aarch64) NAPI_ARCH="arm64" ;;
		x86_64)NAPI_ARCH="x64" ;;
	esac
	local PACKAGE_NAME="@next/swc-android-${NAPI_ARCH}"
	local INSTALL_DIR="$CLANDRO_PREFIX/lib/node_modules/${PACKAGE_NAME}"
	local BINARY_NAME="next-swc.android-${NAPI_ARCH}.node"
	mkdir -p "$INSTALL_DIR"
	mkdir -p "$CLANDRO_PREFIX/lib/node_modules/next/next-swc-fallback/@next/swc-android-${NAPI_ARCH}/"
	install -Dm755 "native/${BINARY_NAME}" "$INSTALL_DIR/${BINARY_NAME}"
	install -Dm755 "native/${BINARY_NAME}" "$CLANDRO_PREFIX/lib/node_modules/next/next-swc-fallback/@next/swc-android-${NAPI_ARCH}/${BINARY_NAME}"
	${STRIP} --strip-unneeded "$INSTALL_DIR/${BINARY_NAME}"
	${STRIP} --strip-unneeded "$CLANDRO_PREFIX/lib/node_modules/next/next-swc-fallback/@next/swc-android-${NAPI_ARCH}/${BINARY_NAME}"
	cat > "$INSTALL_DIR/package.json" <<-EOF
		{
			"name": "${PACKAGE_NAME}",
			"version": "$CLANDRO_PKG_VERSION",
			"os": ["android"],
			"cpu": ["${NAPI_ARCH}"],
			"main": "${BINARY_NAME}"
		}
	EOF
	# this fixes 'Error: turbo.createProject is not supported by the wasm bindings' and 'Failed to load SWC binary for android/arm64' in the 'npm run dev -- --turbo' command
	mkdir -p "$CLANDRO_PREFIX/etc/profile.d/"
	cat > "$CLANDRO_PREFIX/etc/profile.d/turbopack.sh" <<-EOF
		export NEXT_TEST_WASM_DIR=/dev/null
		export NEXT_TEST_NATIVE_DIR=$CLANDRO_PREFIX/lib/node_modules/@next/swc-android-arm64
	EOF
	chmod 0755 "$CLANDRO_PREFIX/etc/profile.d/turbopack.sh"
}

clandro_step_create_debscripts() {
	cat > ./postinst <<-EOF
	#!$CLANDRO_PREFIX/bin/sh
	echo "You must explicitly use 'npx create-next-app@v${CLANDRO_PKG_VERSION//\~/-}' to avoid the error of Missing field 'isPersistentCachingEnabled'"
	EOF
}
