CLANDRO_PKG_HOMEPAGE=https://shotcut.org/
CLANDRO_PKG_DESCRIPTION="Cross-platform Qt based Video Editor"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.4.30"
CLANDRO_PKG_SRCURL="https://github.com/mltframework/shotcut/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=c9f79d3b7daa6fa14595c657e907d28c622daa2edda70340c8cf6a9e207cd0f8
CLANDRO_PKG_DEPENDS="ffmpeg, fftw, frei0r-plugins, mlt, libx264, libvpx, lame, ladspa-sdk, movit, qt6-qtbase, qt6-qtcharts, qt6-qtdeclarative, qt6-qtimageformats, qt6-qtmultimedia, qt6-qttranslations, qt6-qtwebsockets, sdl2 | sdl2-compat"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qttools"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_AUTO_UPDATE=true
# if CMAKE_SYSTEM_NAME is left as Android,
# will fail to detect Qt6::DBus and fail to compile
# https://github.com/mltframework/shotcut/commit/f0f5f18125d73e55e7f32ff1b106e24558de1cf5
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"

clandro_step_pre_configure(){
	CXXFLAGS+=' -Wno-c++11-narrowing'
}
