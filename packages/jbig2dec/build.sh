CLANDRO_PKG_HOMEPAGE=https://jbig2dec.com/
CLANDRO_PKG_DESCRIPTION="Decoder implementation of the JBIG2 image compression format"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.20
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ArtifexSoftware/jbig2dec/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a9705369a6633aba532693450ec802c562397e1b824662de809ede92f67aff21
CLANDRO_PKG_DEPENDS="libpng"
CLANDRO_PKG_BREAKS="jbig2dec-dev"
CLANDRO_PKG_REPLACES="jbig2dec-dev"

clandro_step_pre_configure() {
	./autogen.sh
}
