CLANDRO_PKG_HOMEPAGE=https://numpy.org/
CLANDRO_PKG_DESCRIPTION="The fundamental package for scientific computing with Python"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
# Revbump revdeps after updating
CLANDRO_PKG_VERSION="2.4.4"
CLANDRO_PKG_SRCURL="https://github.com/numpy/numpy/releases/download/v$CLANDRO_PKG_VERSION/numpy-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=2d390634c5182175533585cc89f3608a4682ccb173cc9bb940b2881c8d6f8fa0
CLANDRO_PKG_DEPENDS="libc++, libopenblas, python"
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, 'Cython>=3.0.6', 'meson-python>=0.18.0', build"

CLANDRO_MESON_WHEEL_CROSSFILE="$CLANDRO_PKG_TMPDIR/wheel-cross-file.txt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cross-file $CLANDRO_MESON_WHEEL_CROSSFILE
"

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/
"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}

clandro_step_configure() {
	clandro_setup_meson

	cp -f "$CLANDRO_MESON_CROSSFILE" "$CLANDRO_MESON_WHEEL_CROSSFILE"
	sed -i 's|^\(\[binaries\]\)$|\1\npython = '\'$(command -v python)\''|g' \
		"$CLANDRO_MESON_WHEEL_CROSSFILE"
	sed -i 's|^\(\[properties\]\)$|\1\nnumpy-include-dir = '\'$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include\''|g' \
		"$CLANDRO_MESON_WHEEL_CROSSFILE"

	local _longdouble_format=""
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		_longdouble_format="IEEE_DOUBLE_LE"
	else
		_longdouble_format="IEEE_QUAD_LE"
	fi
	sed -i 's|^\(\[properties\]\)$|\1\nlongdouble_format = '\'$_longdouble_format\''|g' \
		"$CLANDRO_MESON_WHEEL_CROSSFILE"

	local _meson_buildtype="minsize"
	local _meson_stripflag="--strip"
	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		_meson_buildtype="debug"
		_meson_stripflag=
	fi

	local _custom_meson="build-python"
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		_custom_meson="python"
	fi
	_custom_meson+=" $CLANDRO_PKG_SRCDIR/vendored-meson/meson/meson.py"
	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $_custom_meson \
		"$CLANDRO_PKG_SRCDIR" \
		"$CLANDRO_PKG_BUILDDIR" \
		--cross-file "$CLANDRO_MESON_CROSSFILE" \
		--prefix "$CLANDRO_PREFIX" \
		--libdir lib \
		--buildtype "${_meson_buildtype}" \
		${_meson_stripflag} \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_make() {
	pushd "$CLANDRO_PKG_SRCDIR"
	python -m build -w -n -x --config-setting builddir="$CLANDRO_PKG_BUILDDIR" .
	popd
}

clandro_step_make_install() {
	# during on-device build, for some reason the .whl file will have a different name from cross-compilation
	local wheel_arch="$CLANDRO_ARCH"
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		case "$CLANDRO_ARCH" in
			aarch64) wheel_arch=arm64_v8a ;;
			arm)     wheel_arch=armeabi_v7a ;;
			x86_64)  wheel_arch=x86_64 ;;
			i686)    wheel_arch=x86 ;;
			*)
				echo "ERROR: Unknown architecture: $CLANDRO_ARCH"
				return 1 ;;
		esac
		wheel_arch="${CLANDRO_PKG_API_LEVEL}_${wheel_arch}"
	fi
	local _pyv="${CLANDRO_PYTHON_VERSION/./}"
	local _whl="numpy-$CLANDRO_PKG_VERSION-cp$_pyv-cp$_pyv-android_$wheel_arch.whl"
	pip install --no-deps --prefix="$CLANDRO_PREFIX" --force-reinstall "$CLANDRO_PKG_SRCDIR/dist/$_whl"
}
