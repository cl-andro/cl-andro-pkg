CLANDRO_PKG_HOMEPAGE=http://www.figlet.org/
CLANDRO_PKG_DESCRIPTION="Program for making large letters out of ordinary text"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.5
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LD=$CC
}
