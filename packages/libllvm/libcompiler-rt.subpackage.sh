CLANDRO_SUBPKG_DESCRIPTION="Compiler runtime libraries for clang"
CLANDRO_SUBPKG_INCLUDE="
include/fuzzer/FuzzedDataProvider.h
include/orc/
include/profile/
include/sanitizer/
include/xray/
lib/clang/*/bin/asan_device_setup
lib/clang/*/bin/hwasan_symbolize
lib/clang/*/lib/linux/
lib/clang/*/share/asan_ignorelist.txt
lib/clang/*/share/cfi_ignorelist.txt
lib/clang/*/share/hwasan_ignorelist.txt
share/libalpm/hooks/update-libcompiler-rt.hook
share/libalpm/scripts/update-libcompiler-rt
"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS=libc++
# file include/fuzzer/FuzzedDataProvider.h is now in libcompiler-rt instead of libllvm
CLANDRO_SUBPKG_CONFLICTS="libllvm (<< 21.1.3), ndk-multilib (<< 23b-6)"

clandro_step_create_subpkg_debscripts() {
	local RT_OPT_DIR="$CLANDRO_PREFIX/opt/ndk-multilib/cross-compiler-rt"
	local RT_PATH="$CLANDRO_PREFIX/lib/clang/${CLANDRO_PKG_VERSION%%.*}/lib/linux"

	cat <<- EOF > ./triggers
	interest-noawait $RT_OPT_DIR
	EOF

	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	if [[ -e "$RT_OPT_DIR" ]]; then
	    find $RT_OPT_DIR -type f ! -name "lib*-$CLANDRO_ARCH-*" -exec ln -sf "{}" $RT_PATH \;
	fi
	exit 0
	EOF
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi

	cat <<- EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	find $RT_PATH -type l ! -name "lib*-$CLANDRO_ARCH-*" -exec rm -rf "{}" \;
	exit 0
	EOF
}
