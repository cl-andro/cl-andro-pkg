CLANDRO_PKG_HOMEPAGE=https://speex.org/
CLANDRO_PKG_DESCRIPTION="Speex audio processing library"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/xiph/speexdsp/archive/refs/tags/SpeexDSP-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d17ca363654556a4ff1d02cc13d9eb1fc5a8642c90b40bd54ce266c3807b91a7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_BREAKS="speexdsp-dev"
CLANDRO_PKG_REPLACES="speexdsp-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-neon"
CLANDRO_PKG_RM_AFTER_INSTALL="share/doc/speexdsp/manual.pdf"

clandro_step_pre_configure() {
	./autogen.sh
}
