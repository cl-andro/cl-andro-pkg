CLANDRO_SUBPKG_DESCRIPTION="Install native static libs from NDK"
# Existence of libfoo.a without stub libfoo.so causes troubles.
CLANDRO_SUBPKG_DEPENDS="ndk-multilib-native-stubs"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=false
CLANDRO_SUBPKG_INCLUDE=

case "$CLANDRO_ARCH" in
	aarch64 )
		CLANDRO_SUBPKG_INCLUDE+="
			aarch64-linux-android/lib/libc.a
			aarch64-linux-android/lib/libdl.a
			aarch64-linux-android/lib/libm.a
		"
		;& # fallthrough
	arm )
		CLANDRO_SUBPKG_INCLUDE+="
			arm-linux-androideabi/lib/libc.a
			arm-linux-androideabi/lib/libdl.a
			arm-linux-androideabi/lib/libm.a
		"
		;;
	x86_64 )
		CLANDRO_SUBPKG_INCLUDE+="
			x86_64-linux-android/lib/libc.a
			x86_64-linux-android/lib/libdl.a
			x86_64-linux-android/lib/libm.a
		"
		;& # fallthrough
	i686 )
		CLANDRO_SUBPKG_INCLUDE+="
			i686-linux-android/lib/libc.a
			i686-linux-android/lib/libdl.a
			i686-linux-android/lib/libm.a
		"
		;;
esac
