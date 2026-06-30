CLANDRO_PKG_HOMEPAGE=https://dri.freedesktop.org/wiki/
CLANDRO_PKG_DESCRIPTION="Userspace interface to kernel DRM services"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.133"
CLANDRO_PKG_SRCURL=https://dri.freedesktop.org/libdrm/libdrm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=fc68f9d0ba2ea63c9432a299e14fea09fad7a8a66e8039fcd7802ca59f77b4f5
CLANDRO_PKG_AUTO_UPDATE=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintel=disabled
-Dradeon=disabled
-Damdgpu=disabled
-Dnouveau=disabled
-Dvmwgfx=disabled
-Dtests=false
"

clandro_step_pre_configure() {
	CFLAGS="${CFLAGS} -DANDROID"
}

clandro_step_install_license() {
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		$CLANDRO_PKG_BUILDER_DIR/LICENSE
}
