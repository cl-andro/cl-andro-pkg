CLANDRO_PKG_HOMEPAGE=https://www.nongnu.org/devilspie2/
CLANDRO_PKG_DESCRIPTION="A window-matching utility"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.45"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download.savannah.nongnu.org/releases/devilspie2/devilspie2_${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=6cc55a68ccfd8bb5620f4cd7c9913ef29aba8a9e96648497c5b448fdb97cb034
CLANDRO_PKG_DEPENDS="glib, gtk3, lua54, libwnck, libx11, libxinerama, libxrandr"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="LUA=lua54"

clandro_step_post_configure() {
	mkdir -p obj
}
