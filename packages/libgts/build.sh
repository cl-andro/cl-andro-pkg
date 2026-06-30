CLANDRO_PKG_HOMEPAGE=https://gts.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Provides useful functions to deal with 3D surfaces meshed with interconnected triangles"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.6"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/project/gts/gts/${CLANDRO_PKG_VERSION}/gts-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=059c3e13e3e3b796d775ec9f96abdce8f2b3b5144df8514eda0cc12e13e8b81e
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	# predicates_init executable generates predicates_init.h
	$CLANDRO_PKG_SRCDIR/configure
	make -C src predicates_init
}

# prevents error
# /bin/bash: line 1: ./predicates_init: cannot execute binary file: Exec format error
# during repeated builds
clandro_step_pre_configure() {
	rm -rf "$CLANDRO_HOSTBUILD_MARKER"
}
