CLANDRO_PKG_HOMEPAGE=https://www.gust.org.pl/projects/e-foundry/tex-gyre/
CLANDRO_PKG_DESCRIPTION="The TeX Gyre (TG) Collection of Fonts"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="GUST-FONT-LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.501
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.gust.org.pl/projects/e-foundry/tex-gyre/whole/tg${CLANDRO_PKG_VERSION//./_}otf.zip
CLANDRO_PKG_SHA256=d7f8be5317bec4e644cf16c5abf876abeeb83c43dbec0ccb4eee4516b73b1bbe
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	clandro_download https://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt \
		$CLANDRO_PKG_SRCDIR/GUST-FONT-LICENSE.txt \
		5eb61bb836bb1845ef668717cb15b382e997748ce2629e4388cc5e4c3fa4e433
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/share/fonts/tex-gyre *.otf
}
