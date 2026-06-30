CLANDRO_SUBPKG_DESCRIPTION="Install native stubs for shared libs from NDK"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=false
CLANDRO_SUBPKG_INCLUDE=

case "$CLANDRO_ARCH" in
	aarch64 )
		CLANDRO_SUBPKG_INCLUDE+="
			aarch64-linux-android/lib/libc.so
			aarch64-linux-android/lib/libdl.so
			aarch64-linux-android/lib/liblog.so
			aarch64-linux-android/lib/libm.so
		"
		;& # fallthrough
	arm )
		CLANDRO_SUBPKG_INCLUDE+="
			arm-linux-androideabi/lib/libc.so
			arm-linux-androideabi/lib/libdl.so
			arm-linux-androideabi/lib/liblog.so
			arm-linux-androideabi/lib/libm.so
		"
		;;
	x86_64 )
		CLANDRO_SUBPKG_INCLUDE+="
			x86_64-linux-android/lib/libc.so
			x86_64-linux-android/lib/libdl.so
			x86_64-linux-android/lib/liblog.so
			x86_64-linux-android/lib/libm.so
		"
		;& # fallthrough
	i686 )
		CLANDRO_SUBPKG_INCLUDE+="
			i686-linux-android/lib/libc.so
			i686-linux-android/lib/libdl.so
			i686-linux-android/lib/liblog.so
			i686-linux-android/lib/libm.so
		"
		;;
esac
