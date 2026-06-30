CLANDRO_PKG_HOMEPAGE=https://tigervnc.org/
CLANDRO_PKG_DESCRIPTION="Suite of VNC servers. Based on the VNC 4 branch of TightVNC."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(1.16.2
# Align the version with `xorg-server` package.
                    21.1.16)
CLANDRO_PKG_SRCURL=("https://github.com/TigerVNC/tigervnc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
                   "https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-${CLANDRO_PKG_VERSION[1]}.tar.xz")
CLANDRO_PKG_SHA256=(
	b107c0c8b8a962594281690366c24186e95c2ea4a169acbc0076aa62ed01f467
	b14a116d2d805debc5b5b2aac505a279e69b217dae2fae2dfcb62400471a9970
)
CLANDRO_PKG_DEPENDS="libandroid-shmem, libc++, libgmp, libgnutls, libjpeg-turbo, libnettle, libpixman, libx11, libxau, libxdamage, libxdmcp, libxext, libxfixes, libxfont2, libxrandr, libxshmfence, libxtst, opengl, openssl, perl, xkeyboard-config, xorg-xauth, xorg-xkbcomp, zlib"
CLANDRO_PKG_BUILD_DEPENDS="xorg-font-util, xorg-server, xorg-util-macros, xorgproto, xtrans"
CLANDRO_PKG_SUGGESTS="aterm, xorg-twm"

CLANDRO_PKG_FOLDERNAME="tigervnc-${CLANDRO_PKG_VERSION}"
# Viewer has a separate package tigervnc-viewer. Do not build viewer here.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_VIEWER=OFF
-DENABLE_NLS=OFF
-DENABLE_PAM=OFF
-DENABLE_GNUTLS=ON
-DFLTK_MATH_LIBRARY=
"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	## TigerVNC requires sources of X server (either Xorg or Xvfb).
	cp -r xorg-server-${CLANDRO_PKG_VERSION[1]}/* unix/xserver/

	cd ${CLANDRO_PKG_BUILDDIR}/unix/xserver
	for p in "$CLANDRO_SCRIPTDIR/x11-packages/xorg-server"/*.patch; do
		echo "Applying $(basename "${p}")"
		sed -e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
			-e "s%\@CLANDRO_HOME\@%${CLANDRO_ANDROID_HOME}%g" "$p" \
			| patch --silent -p1
	done

	patch -p1 -i ${CLANDRO_PKG_BUILDER_DIR}/xserver21.1.1.diff
}

clandro_step_pre_configure() {
	cd ${CLANDRO_PKG_BUILDDIR}/unix/xserver

	autoreconf -fi

	CFLAGS="${CFLAGS/-Os/-Oz} -DFNDELAY=O_NDELAY -DINITARGS=void"
	CPPFLAGS="${CPPFLAGS} -I${CLANDRO_PREFIX}/include/libdrm"

	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS="${LDFLAGS} -llog -L$_libgcc_path -l:$_libgcc_name"

	local xorg_server_configure_args="$(. $CLANDRO_SCRIPTDIR/x11-packages/xorg-server/build.sh; echo $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS)"
	xorg_server_configure_args+=" --disable-xorg --disable-xephyr --disable-kdrive"
	./configure \
		--host="${CLANDRO_HOST_PLATFORM}" \
		--prefix="${CLANDRO_PREFIX}" \
		--disable-static \
		--disable-nls \
		--enable-debug \
		${xorg_server_configure_args}

	LDFLAGS="${LDFLAGS} -landroid-shmem"
}

clandro_step_post_make_install() {
	cd ${CLANDRO_PKG_BUILDDIR}/unix/xserver
	make -j ${CLANDRO_PKG_MAKE_PROCESSES}

	cd ${CLANDRO_PKG_BUILDDIR}/unix/xserver/hw/vnc
	make install

	## use custom variant of vncserver script
	cp -f "${CLANDRO_PKG_BUILDER_DIR}/vncserver" "${CLANDRO_PREFIX}/bin/vncserver"
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" "${CLANDRO_PREFIX}/bin/vncserver"
}

clandro_step_post_massage() {
	find lib -name '*.la' -delete
}
