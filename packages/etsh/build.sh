CLANDRO_PKG_HOMEPAGE=https://etsh.nl
CLANDRO_PKG_DESCRIPTION="An enhanced, backward-compatible port of Thompson Shell"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.4.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://etsh.nl/src/etsh_${CLANDRO_PKG_VERSION}/etsh-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=fd4351f50acbb34a22306996f33d391369d65a328e3650df75fb3e6ccacc8dce
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	sh ./mkconfig
}
