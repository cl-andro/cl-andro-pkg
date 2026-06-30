CLANDRO_PKG_HOMEPAGE=https://github.com/vinceliuice/Fluent-gtk-theme
CLANDRO_PKG_DESCRIPTION="Fluent is a Fluent design theme for GNOME/GTK based desktop environments"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.04.17"
CLANDRO_PKG_SRCURL=https://github.com/vinceliuice/Fluent-gtk-theme/archive/refs/tags/${CLANDRO_PKG_VERSION//./-}.tar.gz
CLANDRO_PKG_SHA256=bedc51e07ca4edaeb3bdd50e9e2a27c10f1b049f460b10e3b5668d11ff2b03cd
CLANDRO_PKG_DEPENDS="gnome-themes-extra, gtk2-engines-murrine, gtk3"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_make_install(){
	./install.sh -d ${CLANDRO_PREFIX}/share/themes
}
