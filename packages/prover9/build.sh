CLANDRO_PKG_HOMEPAGE=https://www.cs.unm.edu/~mccune/prover9/
CLANDRO_PKG_DESCRIPTION="An automated theorem prover for first-order and equational logic"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2009-11A
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.cs.unm.edu/~mccune/mace4/download/LADR-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c32bed5807000c0b7161c276e50d9ca0af0cb248df2c1affb2f6fc02471b51d0
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-e all"
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/*
}
