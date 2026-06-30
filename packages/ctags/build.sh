CLANDRO_PKG_HOMEPAGE=https://ctags.io/
CLANDRO_PKG_DESCRIPTION="Universal ctags: Source code index builder"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:6.2.1"
CLANDRO_PKG_SRCURL=https://github.com/universal-ctags/ctags/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=f56829e9a576025e98955597ee967099a871987b3476fbd8dbbc2b9dc921f824
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libiconv, libjansson, libxml2, libyaml"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-tmpdir=$CLANDRO_PREFIX/tmp --disable-static"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	./autogen.sh
}
