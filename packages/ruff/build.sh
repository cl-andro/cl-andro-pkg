CLANDRO_PKG_HOMEPAGE="https://github.com/charliermarsh/ruff"
CLANDRO_PKG_DESCRIPTION="An extremely fast Python linter, written in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.15.12"
CLANDRO_PKG_SRCURL="https://github.com/charliermarsh/ruff/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=368b5af4b9373123a58d3e8cf702ab5584dd359c9bfeaec8f08fa2a1b27bea93
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="maturin"

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -rf _lib
	mkdir -p _lib
	cd _lib
	$CC $CPPFLAGS $CFLAGS -fvisibility=hidden \
		-c $CLANDRO_PKG_BUILDER_DIR/ctermid.c
	$AR cru libctermid.a ctermid.o

	local env_host="$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)"
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$CLANDRO_PKG_BUILDDIR/_lib/libctermid.a"

	export ANDROID_API_LEVEL="$CLANDRO_PKG_API_LEVEL"
}

clandro_step_make() {
	# --skip-auditwheel workaround for Maturin error
	# 'Cannot repair wheel, because required library libdl.so could not be located.'
	# found here in Termux-specific upstream discussion: https://github.com/PyO3/pyo3/issues/2324
	export CARGO_BUILD_TARGET="${CARGO_TARGET_NAME}"
	export PYO3_CROSS_LIB_DIR="${CLANDRO_PREFIX}/lib"
	export ANDROID_API_LEVEL="${CLANDRO_PKG_API_LEVEL}"
	maturin build --locked --skip-auditwheel --release --all-features --strip
}

clandro_step_make_install() {
	install -Dm755 -t "$CLANDRO_PREFIX/bin" "target/$CARGO_TARGET_NAME/release/ruff"

	# ERROR: ruff-0.11.9-py3-none-linux_armv7l.whl is not a supported wheel on this platform.
	# seems to be resolved by renaming the .whl file in this way
	local _pyver="${CLANDRO_PYTHON_VERSION/./}"
	local _tag="py3-none"

	local wheel_arch
	case "$CLANDRO_ARCH" in
		aarch64) wheel_arch=arm64_v8a ;;
		arm)     wheel_arch=armeabi_v7a ;;
		x86_64)  wheel_arch=x86_64 ;;
		i686)    wheel_arch=x86 ;;
		*)
			echo "ERROR: Unknown architecture: $CLANDRO_ARCH"
			return 1 ;;
	esac

	mv "target/wheels/ruff-${CLANDRO_PKG_VERSION}-${_tag}-android_${CLANDRO_PKG_API_LEVEL}_${wheel_arch}.whl" \
		"target/wheels/ruff-${CLANDRO_PKG_VERSION}-py${_pyver}-none-any.whl"

	pip install --no-deps --prefix="$CLANDRO_PREFIX" --force-reinstall target/wheels/*.whl
}
