CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/mstoeckl/waypipe
CLANDRO_PKG_DESCRIPTION="A proxy for Wayland clients"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.0"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/mstoeckl/waypipe/-/archive/v${CLANDRO_PKG_VERSION}/waypipe-v${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=e75e4bb5471e6f413aae1e00b0abddf02ec9f1f56db31d4c50535436c4e7282d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-spawn, liblz4, libwayland, zstd"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-protocols, libwayland-cross-scanner, scdoc"
# confusing preprocessor feature matrix in waypipe:
# https://gitlab.freedesktop.org/mstoeckl/waypipe/-/blob/a04f6e3573f19ec7d7a7ef74b3fd1ee52400a2f7/src/video.c#L28-L77
# -Dwith_dmabuf=disabled appears to cause -Dwith_video=enabled to have no effect,
# preventing the compilation of any calls to FFmpeg API.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild_c=true
-Dbuild_rs=false
-Dman-pages=enabled
-Dtests=false
-Dwerror=false
-Dwith_video=disabled
-Dwith_dmabuf=disabled
-Dwith_lz4=enabled
-Dwith_zstd=enabled
-Dwith_vaapi=disabled
-Dwith_secctx=enabled
-Dwith_systemtap=false
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
	LDFLAGS+=" -landroid-spawn"
}

clandro_step_post_make_install() {
	# keep executable name same as previous
	mv -v "${CLANDRO_PREFIX}"/bin/{waypipe-c,waypipe}
}
