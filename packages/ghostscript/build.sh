CLANDRO_PKG_HOMEPAGE=https://www.ghostscript.com/
CLANDRO_PKG_DESCRIPTION="Interpreter for the PostScript language and for PDF"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="10.07.0"
CLANDRO_PKG_SRCURL="https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${CLANDRO_PKG_VERSION//.}/ghostpdl-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=93dc72ee259374f0b576fb926bbe3648504020c75638c302bd144f94f1641ae2
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="fontconfig, freetype, jbig2dec, leptonica, libandroid-support, libc++, libiconv, libidn, libjpeg-turbo, libpng, libtiff, littlecms, openjpeg, zlib"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, libexpat"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lcms2__cmsCreateMutex=yes
ac_cv_lib_pthread_pthread_create=yes
CCAUX=gcc
--build=$CLANDRO_BUILD_TUPLE
--disable-cups
--disable-compile-inits
--without-pcl
--without-x
--with-system-libtiff
"
CLANDRO_PKG_MAKE_INSTALL_TARGET="install-so install"

clandro_step_post_get_source() {
	rm -rdf "$CLANDRO_PKG_SRCDIR"/{expat,freetype,jbig2dec,jpeg,lcms2mt,leptonica,libpng,openjpeg,tiff,zlib}
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
		local patch="$CLANDRO_PKG_BUILDER_DIR/genarch-termux-proot-run.diff"
		echo "Applying $(basename "${patch}")"
		patch --silent -p1 < "${patch}"
	else
		export PKGCONFIG="$PKG_CONFIG"
		export LDFLAGS+=" -liconv"
	fi

	if [[ "${CLANDRO_ARCH}" == "aarch64" ]]; then
		# https://github.com/llvm/llvm-project/issues/74361
		# NDK r27: clang++: error: unsupported option '-mfpu=' for target 'aarch64-linux-android24'
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-neon"
	fi
}

clandro_step_make() {
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" \
		so all \
		${CLANDRO_PKG_EXTRA_MAKE_ARGS}
}

clandro_step_post_make_install() {
	mv "$CLANDRO_PREFIX"/bin/gs{c,}
}
