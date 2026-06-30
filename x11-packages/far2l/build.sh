CLANDRO_PKG_HOMEPAGE=https://github.com/elfmz/far2l
CLANDRO_PKG_DESCRIPTION="FAR Manager v2"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.0"
CLANDRO_PKG_SRCURL=https://github.com/elfmz/far2l/archive/refs/tags/v_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b0fddad2e3985f245f9e691e23b90fb97f7d29d9a0b131fe686aa3cbb2e4ea01
CLANDRO_PKG_DEPENDS="libandroid-utimes, libarchive, libc++, libuchardet"
CLANDRO_PKG_SUGGESTS="chafa, exiftool, htop, timg"
CLANDRO_PKG_RM_AFTER_INSTALL="share/icons share/applications"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_BUILD_TYPE=Release
-DANDROID=ON
-DUSEWX=OFF
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-utimes"
}
