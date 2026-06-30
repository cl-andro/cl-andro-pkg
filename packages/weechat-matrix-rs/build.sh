CLANDRO_PKG_HOMEPAGE="https://github.com/poljar/weechat-matrix-rs"
CLANDRO_PKG_DESCRIPTION="Rust rewrite of the python weechat-matrix script"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=ca23e1745e6e2ba235550360e1def1457e2f3857
CLANDRO_PKG_VERSION=2022.10.04
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="git+https://github.com/poljar/weechat-matrix-rs"
CLANDRO_PKG_SHA256=61d4d307167f274c1ee165a7021d5cda330a2331eb89e8add2f027becf8cae0c
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_DEPENDS="weechat, openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
# There are compile errors for 32-bit platforms in weechat-rust dependency
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo vendor
	patch --silent -p1 \
		-d ./vendor/weechat/ \
		< "$CLANDRO_PKG_BUILDER_DIR"/weechat-rust-printf_date_tags.diff

	patch --silent -p1 \
		-d "$CLANDRO_PKG_SRCDIR" \
		< "$CLANDRO_PKG_BUILDER_DIR"/patch-root-Cargo.diff

	export BINDGEN_EXTRA_CLANG_ARGS="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot"
	case "${CLANDRO_ARCH}" in
		arm) BINDGEN_EXTRA_CLANG_ARGS+=" --target=arm-linux-androideabi${CLANDRO_PKG_API_LEVEL}" ;;
		*) BINDGEN_EXTRA_CLANG_ARGS+=" --target=${CLANDRO_ARCH}-linux-android${CLANDRO_PKG_API_LEVEL}" ;;
	esac
}

clandro_step_make() {
	# cmake is needed for building of olm-sys by cargo internally
	clandro_setup_cmake

	# olm-sys needs the path to Android NDK to be built
	export ANDROID_NDK="$NDK"
	# force the plugin to be built against the weechat SDK available in packages
	export WEECHAT_PLUGIN_FILE="$CLANDRO_PREFIX/include/weechat/weechat-plugin.h"
	WEECHAT_PLUGIN_API_VERSION=$(grep 'define WEECHAT_PLUGIN_API_VERSION' \
		"$WEECHAT_PLUGIN_FILE" | cut -d " " -f 3 | tr -d '"')
	printf "WeeChat Plugin API version: %s \n" "$WEECHAT_PLUGIN_API_VERSION"
	[[ -z "$WEECHAT_PLUGIN_API_VERSION" ]] && exit 1

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 target/${CARGO_TARGET_NAME}/release/libmatrix.so \
		"$CLANDRO_PREFIX/lib/weechat/plugins/matrix.so"
}
