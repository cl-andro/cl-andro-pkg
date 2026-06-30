CLANDRO_PKG_HOMEPAGE=https://htop.dev/
CLANDRO_PKG_DESCRIPTION="Interactive process viewer for Linux"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.1"
CLANDRO_PKG_SRCURL=https://github.com/htop-dev/htop/archive/refs/tags/${CLANDRO_PKG_VERSION}/htop-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dfc4a09845e9bc86f466a722e62b8f87d59028ff39689077ff2257a6a605061d
# htop checks setlocale() return value for UTF-8 support, so use libandroid-support.
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"
CLANDRO_PKG_BREAKS="htop-legacy"
CLANDRO_PKG_CONFLICTS="htop-legacy"
CLANDRO_PKG_REPLACES="htop-legacy"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
ac_cv_lib_ncursesw6_addnwstr=yes
LIBS=-landroid-support
"

clandro_step_pre_configure() {
	./autogen.sh
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX/var/htop"
	cp -a "$CLANDRO_PKG_BUILDER_DIR/procstat" "$CLANDRO_PREFIX/var/htop/stat"
}
