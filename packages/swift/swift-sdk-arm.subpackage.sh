CLANDRO_SUBPKG_DESCRIPTION="Swift SDK for Android armv7"
CLANDRO_SUBPKG_INCLUDE="
lib/swift/android/armv7/*.swiftdoc
lib/swift/android/armv7/*.swiftmodule
lib/swift/android/armv7/android.modulemap
lib/swift/android/armv7/lib_TestDiscovery.a
lib/swift/android/armv7/libswiftCxx.a
lib/swift/android/armv7/libswiftCxxStdlib.a
lib/swift/android/armv7/SwiftAndroidNDK.h
lib/swift/android/armv7/SwiftBionic.h
lib/swift/android/armv7/swiftrt.o
lib/swift/android/*.swiftmodule/armv7*
lib/swift_static/android/armv7/
lib/swift_static/android/*.swiftmodule/armv7*
"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=true
CLANDRO_SUBPKG_DEPENDS="swift-runtime-arm"
CLANDRO_SUBPKG_BREAKS="swift (<< 5.8)"
CLANDRO_SUBPKG_REPLACES="swift (<< 5.8)"
