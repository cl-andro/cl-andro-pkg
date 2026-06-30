CLANDRO_PKG_HOMEPAGE=https://www.vapoursynth.com/
CLANDRO_PKG_DESCRIPTION="Video processing framework with simplicity in mind"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="73"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/vapoursynth/vapoursynth/archive/refs/tags/R${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1bb8ffe31348eaf46d8f541b138f0136d10edaef0c130c1e5a13aa4a4b057280
CLANDRO_PKG_DEPENDS="libzimg, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="Cython"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS=" --disable-x86-asm"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='R\d{2}(?!-)'

clandro_step_pre_configure() {
	rm -f "$CLANDRO_PKG_SRCDIR/setup.py"

	if [[ "$CLANDRO_ARCH" == 'aarch64' ]]; then
		export CFLAGS+=" -march=armv8.1-a"
		export CXXFLAGS+=" -march=armv8.1-a"
	fi

	# Workaround borrowed from https://github.com/termux/termux-packages/pull/22212/files
	local _libgcc_file _libgcc_path _libgcc_name
	_libgcc_file="$($CC -print-libgcc-file-name)"
	_libgcc_path="$(dirname "$_libgcc_file")"
	_libgcc_name="$(basename "$_libgcc_file")"

	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/vapoursynth"

	./autogen.sh
}
