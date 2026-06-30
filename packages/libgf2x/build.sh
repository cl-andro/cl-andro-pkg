CLANDRO_PKG_HOMEPAGE="https://gitlab.inria.fr/gf2x/gf2x"
CLANDRO_PKG_DESCRIPTION="A library for multiplying polynomials over the binary field"
CLANDRO_PKG_GROUPS="science"
# Using file:'toom-gpl.c' enforces GPL license
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://gitlab.inria.fr/gf2x/gf2x/-/archive/gf2x-$CLANDRO_PKG_VERSION/gf2x-gf2x-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=11bcf98b620c60c2ee3b4460b02b7be741f14cfdc26b542f22c92950926575e0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+(?!rc)'

clandro_step_pre_configure() {
	autoreconf -fi
}
