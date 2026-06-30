CLANDRO_PKG_HOMEPAGE=https://github.com/knik0/faad2
CLANDRO_PKG_DESCRIPTION="Freeware Advanced Audio (AAC) Decoder"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.2"
CLANDRO_PKG_SRCURL="https://github.com/knik0/faad2/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=3fcbd305e4abd34768c62050e18ca0986f7d9c5eca343fb98275418013065c0e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}
