CLANDRO_PKG_HOMEPAGE=https://github.com/Pulse-Eight/platform
CLANDRO_PKG_DESCRIPTION="Platform support library used by libCEC and binary add-ons for Kodi"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.1.0.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/Pulse-Eight/platform/archive/refs/tags/p8-platform-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=064f8d2c358895c7e0bea9ae956f8d46f3f057772cb97f2743a11d478a0f68a0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	# At time of writing (2.1.0.1) code uses std::unary_function, removed in C++ 17:
	CXXFLAGS+=" -std=c++11"
}
