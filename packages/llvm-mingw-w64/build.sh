CLANDRO_PKG_HOMEPAGE=https://github.com/mstorsjo/llvm-mingw
CLANDRO_PKG_DESCRIPTION="MinGW-w64 toolchain based on LLVM"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@licy183"
CLANDRO_PKG_VERSION="20251007"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mstorsjo/llvm-mingw/releases/download/${CLANDRO_PKG_VERSION}/llvm-mingw-${CLANDRO_PKG_VERSION}-ucrt-ubuntu-22.04-x86_64.tar.xz
CLANDRO_PKG_SHA256=ee1c1f3e4a584f231b1d664eb1f4b9d9f7cae133b64b55dae749f50969cef958
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="clang (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION), llvm (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION), llvm-tools (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION)"
CLANDRO_PKG_RECOMMENDS="llvm-mingw-w64-tools"
CLANDRO_PKG_CONFLICTS="mingw-w64"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_NO_OPENMP_CHECK=true

clandro_step_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", llvm-mingw-w64-libcompiler-rt, llvm-mingw-w64-ucrt"
}

clandro_step_make_install() {
	# Install compier-rt libraries
	rm -rf "$CLANDRO_PREFIX/lib/clang/${CLANDRO_LLVM_MAJOR_VERSION}/lib/windows"
	mkdir -p "$CLANDRO_PREFIX/lib/clang/${CLANDRO_LLVM_MAJOR_VERSION}/lib/windows"
	mv "$CLANDRO_PKG_SRCDIR/lib/clang/${CLANDRO_LLVM_MAJOR_VERSION}/lib/windows" "$CLANDRO_PREFIX/lib/clang/${CLANDRO_LLVM_MAJOR_VERSION}/lib/"

	# Install ucrt libraries
	mkdir -p "$CLANDRO_PREFIX/opt/llvm-mingw-w64"
	rm -rf "$CLANDRO_PREFIX/opt/llvm-mingw-w64"/{aarch64,armv7,i686,x86_64,generic}-w64-mingw32
	mv "$CLANDRO_PKG_SRCDIR"/{aarch64,armv7,i686,x86_64,generic}-w64-mingw32 "$CLANDRO_PREFIX/opt/llvm-mingw-w64"

	# Install the toolchain binaries
	rm -rf "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"
	mkdir -p "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"
	# shellcheck disable=SC2164
	cd "$CLANDRO_PKG_SRCDIR/bin"

	# These files are packaged in llvm-mingw-w64-tools
	rm ./*widl gendef

	# Do not package lldb
	rm ./*lldb*

	# On Termux, use the wrapper script rather than the wrapper binary
	rm ./*wrapper
	rm ./*wrapper.sh.orig || true

	# Install config files
	mv ./mingw32-common.cfg "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"
	mv ./{aarch64,armv7,i686,x86_64}*.cfg "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"

	# Install prefixed scripts
	mv ./{aarch64,armv7,i686,x86_64}* "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"
	mv ./*wrapper.sh "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"

	# Symlinks clang, lld and llvm tools
	local _tool _toolname
	for _tool in ./*; do
		_toolname="$(basename "$_tool")"
		ln -sfr "$CLANDRO_PREFIX/bin/$_toolname" "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"
	done

	# Symlinks prefixed scripts to $PREFIX/bin
	for _tool in "$CLANDRO_PREFIX/opt/llvm-mingw-w64/bin"/{aarch64,armv7,i686,x86_64}-w64-mingw32*; do
		if [[ ! -e "$CLANDRO_PREFIX/bin/$(basename "$_tool")" ]]; then
			ln -sfr "$_tool" "$CLANDRO_PREFIX/bin/$(basename "$_tool")"
		fi
	done
}

clandro_step_install_license() {
	# Install the LICENSE of llvm-mingw-w64-libcompiler-rt
	mkdir -p "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64-libcompiler-rt"
	cp "$CLANDRO_PKG_SRCDIR/LICENSE.TXT" "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64-libcompiler-rt/"

	# Runtimes are consist of runtimes libraries from mingw-w64 and libunwind/libc++ from LLVM
	mkdir -p "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64-ucrt"

	# Install the license of mingw-w64 and mingw-w64-runtimes
	local _file
	for _file in "$CLANDRO_PREFIX"/opt/llvm-mingw-w64/aarch64-w64-mingw32/share/mingw32/*; do
		cp "$_file" "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64-ucrt/"
	done

	# Install the license of libc++ and libunwind
	cp "$CLANDRO_PKG_SRCDIR/LICENSE.TXT" "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64-ucrt/LICENSE-LLVM.TXT"

	# Install the license of the llvm-mingw-w64 toolchain
	mkdir -p "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64"
	cp "$CLANDRO_PKG_SRCDIR/LICENSE.TXT" "$CLANDRO_PREFIX/share/doc/llvm-mingw-w64/copyright"
}
