CLANDRO_PKG_HOMEPAGE=https://gitlab.com/nick87720z/tint2
CLANDRO_PKG_DESCRIPTION="Lightweight panel, Highly customizable"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="17.1.3"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://gitlab.com/nick87720z/tint2/-/archive/v${CLANDRO_PKG_VERSION}/tint2-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=283e193c3bed452e9d2ecbc64c21303ca3e3cc8a5f0a1e16550cbdae97514a23
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, imlib2, libandroid-shmem, libandroid-wordexp, libcairo, librsvg, libx11, libxcomposite, libxdamage, libxext, libxinerama, libxrandr, libxrender, pango, startup-notification"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem -landroid-wordexp -lm"
}
