CLANDRO_PKG_HOMEPAGE=https://libmpeg2.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="MPEG-2 decoder libraries"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download.videolan.org/contrib/libmpeg2/libmpeg2-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dee22e893cb5fc2b2b6ebd60b88478ab8556cb3b93f9a0d7ce8f3b61851871d4
# this package is not in x11-repo, so its X11 features should not
# be auto-enabled even if X11 libraries are detected in the $CLANDRO_PREFIX.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
no_x=yes
"

clandro_step_pre_configure() {
	autoreconf -vfi
}
