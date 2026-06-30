CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/soxr/
CLANDRO_PKG_DESCRIPTION="High quality, one-dimensional sample-rate conversion library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.3"
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/soxr/files/soxr-$CLANDRO_PKG_VERSION-Source.tar.xz
CLANDRO_PKG_SHA256=b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889
CLANDRO_PKG_BREAKS="libsoxr-dev"
CLANDRO_PKG_REPLACES="libsoxr-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	LDFLAGS+=" -fopenmp -static-openmp"
}
