CLANDRO_PKG_HOMEPAGE=https://github.com/vinceliuice/Fluent-icon-theme
CLANDRO_PKG_DESCRIPTION="Fluent icon theme for linux desktops"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.08.21"
CLANDRO_PKG_SRCURL=https://github.com/vinceliuice/Fluent-icon-theme/archive/refs/tags/${CLANDRO_PKG_VERSION//./-}.tar.gz
CLANDRO_PKG_SHA256=553305e3882c896b6f82e12db1dfc9549af63487a8cd26fd5a08303298aedbe3
CLANDRO_PKG_DEPENDS="hicolor-icon-theme"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_RM_AFTER_INSTALL="share/icons/*/icon-theme.cache"
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_REPOLOGY_METADATA_VERSION="${CLANDRO_PKG_VERSION//./}"

clandro_step_make_install(){
	./install.sh -d ${CLANDRO_PREFIX}/share/icons
}
