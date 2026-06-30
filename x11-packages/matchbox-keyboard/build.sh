CLANDRO_PKG_HOMEPAGE=https://www.yoctoproject.org/software-item/matchbox/
CLANDRO_PKG_DESCRIPTION="An on-screen virtual keyboard."
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.1
CLANDRO_PKG_REVISION=31
CLANDRO_PKG_SRCURL=https://git.yoctoproject.org/matchbox-keyboard/snapshot/matchbox-keyboard-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dd3e9494a9499a3bf3017c8c1e6572a4e91deb20e219717db17c0977750b8bcb
CLANDRO_PKG_DEPENDS="libexpat, libfakekey, libpng, libx11, libxft, libxrender"
CLANDRO_PKG_RECOMMENDS="ttf-dejavu"

clandro_step_pre_configure() {
	autoreconf -i
}
