CLANDRO_PKG_HOMEPAGE=https://github.com/flightlessmango/MangoHud/
CLANDRO_PKG_DESCRIPTION="A Vulkan overlay layer for monitoring FPS, temperatures, CPU/GPU load and more"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.3"
CLANDRO_PKG_SRCURL=https://github.com/flightlessmango/MangoHud/releases/download/v${CLANDRO_PKG_VERSION}/MangoHud-v${CLANDRO_PKG_VERSION}-Source.tar.xz
CLANDRO_PKG_SHA256=e810ac73163468533ddb7c74b681f1de4992a3d785dce294fee9933ec8956b05
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libwayland, libx11, libxkbcommon"
CLANDRO_PKG_BUILD_DEPENDS="dbus, libandroid-wordexp, nlohmann-json"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddynamic_string_tokens=false
-Dwith_xnvctrl=disabled
"

clandro_step_pre_configure() {
	# Workaround linker error wit version script
	LDFLAGS+=" -Wl,--undefined-version"

	CFLAGS+=" -DRTLD_DEEPBIND=RTLD_NOW"
}
