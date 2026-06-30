CLANDRO_PKG_HOMEPAGE=https://www.chiark.greenend.org.uk/~sgtatham/putty/
CLANDRO_PKG_DESCRIPTION="A terminal integrated SSH/Telnet client"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.83"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://the.earth.li/~sgtatham/putty/${CLANDRO_PKG_VERSION}/putty-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=718777c13d63d0dff91fe03162bc2a05b4dfc8b0827634cd60b51cefdff631c6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libx11, pango"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
