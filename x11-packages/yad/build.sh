CLANDRO_PKG_HOMEPAGE=https://github.com/v1cont/yad
CLANDRO_PKG_DESCRIPTION="Display graphical dialogs from shell scripts or command line"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="14.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/v1cont/yad/releases/download/v${CLANDRO_PKG_VERSION}/yad-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=5cab399af8d9a10b76d477f848180d00addba38f4f1272a05b153a393bba3038
CLANDRO_PKG_DEPENDS="gspell, gtk3, gtksourceview3, libandroid-shmem, webkit2gtk-4.1"
CLANDRO_PKG_BUILD_DEPENDS="libxml2-utils"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	export LDFLAGS+=" -landroid-shmem"
}
