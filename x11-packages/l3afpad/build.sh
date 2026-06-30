CLANDRO_PKG_HOMEPAGE=https://github.com/stevenhoneyman/l3afpad
CLANDRO_PKG_DESCRIPTION="Simple text editor forked from Leafpad, supports GTK+ 3.x"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION=0.8.18.1.11
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/stevenhoneyman/l3afpad/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=86f374b2f950b7c60dda50aa80a5034b8e3c80ded5cd3284c2d5921b31652793
CLANDRO_PKG_DEPENDS="gtk3"

clandro_step_pre_configure() {
	./autogen.sh
}
