CLANDRO_PKG_HOMEPAGE=https://www.wavpack.com/
CLANDRO_PKG_DESCRIPTION="A completely open audio compression format providing lossless, high-quality lossy, and a unique hybrid compression mode"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.9.0"
CLANDRO_PKG_SRCURL=https://github.com/dbry/WavPack/releases/download/${CLANDRO_PKG_VERSION}/wavpack-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b5291bc4e6d69ebbd3da3800c5bf4a70f19bb92679b23e09b3b612c1e648d1ff
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
