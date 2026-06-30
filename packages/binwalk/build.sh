CLANDRO_PKG_HOMEPAGE=https://github.com/ReFirmLabs/binwalk
CLANDRO_PKG_DESCRIPTION="An Binwalk firmware analysis tool."
CLANDRO_PKG_MAINTAINER="@xingguangcuican6666"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_VERSION="3.1.0"
CLANDRO_PKG_SRCURL=https://github.com/ReFirmLabs/binwalk/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=06f595719417b70a592580258ed980237892eadc198e02363201abe6ca59e49a
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libexpat, ttf-dejavu"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag

clandro_step_pre_configure() {
	clandro_setup_rust
}
