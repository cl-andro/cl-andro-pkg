CLANDRO_PKG_HOMEPAGE=https://savannah.nongnu.org/projects/quilt
CLANDRO_PKG_DESCRIPTION="Allows you to easily manage large numbers of patches"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.69"
CLANDRO_PKG_SRCURL=https://savannah.nongnu.org/download/quilt/quilt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=555ddffde22da3c86d1caf5a9c1fb8a152ac2b84730437bd39cc08849c9f4852
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="coreutils, diffstat, gawk, graphviz, perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-diffstat=$CLANDRO_PREFIX/bin/diffstat
--without-7z
--without-rpmbuild
--without-sendmail
"

clandro_step_post_make_install() {
	ln -sf $CLANDRO_PREFIX/bin/gawk $CLANDRO_PREFIX/share/quilt/compat/awk
}
