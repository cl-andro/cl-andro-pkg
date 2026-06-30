CLANDRO_PKG_HOMEPAGE=http://savannah.nongnu.org/projects/attr/
CLANDRO_PKG_DESCRIPTION="Utilities for manipulating filesystem extended attributes (for testing multilib-compilation on bionic)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.2"
CLANDRO_PKG_SRCURL=http://download.savannah.gnu.org/releases/attr/attr-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=39bf67452fa41d0948c2197601053f48b3d78a029389734332a6309a680c6c87
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-gettext=no"
CLANDRO_PKG_RM_AFTER_INSTALL="share/man/man5/attr.5"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_BUILD_MULTILIB=true
