CLANDRO_PKG_HOMEPAGE=https://www.lyx.org
CLANDRO_PKG_DESCRIPTION="WYSIWYM (What You See Is What You Mean) Document Processor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.1"
CLANDRO_PKG_SRCURL="https://ftp.lip6.fr/pub/lyx/stable/${CLANDRO_PKG_VERSION:0:3}.x/lyx-${CLANDRO_PKG_VERSION/p/-}.tar.xz"
CLANDRO_PKG_SHA256=f2a2387bcb3f2f546c1fc13e4c74cb4f8aa648706ce5788ef705dd51344d2cfd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP='s/\./p/3; s/-/p/'
CLANDRO_PKG_DEPENDS="file, ghostscript, hunspell, imagemagick, libandroid-execinfo, libc++, libiconv, libxcb, lyx-data, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, texlive-bin, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-build-type=rel
--without-included-boost
--without-aspell
--with-hunspell
"
CLANDRO_PKG_RM_AFTER_INSTALL="share/lyx/examples"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"

	# This is to allow the build script find the `moc` on cross-build host
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PATH="${CLANDRO_PREFIX}/opt/qt/cross/bin:${PATH}"
	fi
}
