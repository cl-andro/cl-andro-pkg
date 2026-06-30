CLANDRO_PKG_HOMEPAGE=https://github.com/fastfetch-cli/fastfetch
CLANDRO_PKG_DESCRIPTION="A maintained, feature-rich and performance oriented, neofetch like system information tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.62.1"
CLANDRO_PKG_SRCURL=https://github.com/fastfetch-cli/fastfetch/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8c4833e55b8b445a32c7cb7570007b5e10a9ee4cee74a494004ba61e88b12b26
CLANDRO_PKG_BUILD_DEPENDS="chafa, dbus, freetype, glib, imagemagick, libandroid-wordexp-static, libelf, libxcb, libxrandr, mesa-dev, ocl-icd, opencl-headers, pulseaudio, vulkan-headers, vulkan-loader-generic, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DTARGET_DIR_HOME=${CLANDRO_ANDROID_HOME}
-DTARGET_DIR_ROOT=${CLANDRO_PREFIX}
-DTARGET_DIR_USR=${CLANDRO_PREFIX}
"
