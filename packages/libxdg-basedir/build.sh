CLANDRO_PKG_HOMEPAGE=https://github.com/devnev/libxdg-basedir
CLANDRO_PKG_DESCRIPTION="An implementation of the XDG Base Directory specifications"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/devnev/libxdg-basedir/archive/refs/tags/libxdg-basedir-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ff30c60161f7043df4dcc6e7cdea8e064e382aa06c73dcc3d1885c7d2c77451d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology

clandro_step_pre_configure() {
	autoreconf -fi
}
