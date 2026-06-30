CLANDRO_PKG_HOMEPAGE=https://www.povray.org/
CLANDRO_PKG_DESCRIPTION="The Persistence of Vision Raytracer"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.0-beta.2"
CLANDRO_PKG_REVISION=18
CLANDRO_PKG_SRCURL="https://github.com/POV-Ray/povray/releases/download/v${CLANDRO_PKG_VERSION}/povunix-v${CLANDRO_PKG_VERSION}-src.tar.gz"
CLANDRO_PKG_SHA256=4717c9bed114deec47cf04a8175cc4060dafc159f26e7896480a60f4411ca5ad
CLANDRO_PKG_DEPENDS="boost, imath, libc++, libjpeg-turbo, libpng, libtiff, openexr, povray-data, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/doc/povray-*/html
"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--disable-dependency-tracking
--disable-optimiz
--disable-optimiz-arch
--disable-strip
--enable-io-restrictions
--with-boost=$CLANDRO_PREFIX/lib
--with-boost-libdir=$CLANDRO_PREFIX/lib
--without-libmkl
--without-libsdl
--without-x
ax_cv_c_compiler_vendor=clang
ax_cv_cxx_compiler_vendor=clang
COMPILED_BY=Termux
"

clandro_step_pre_configure() {
	# Code uses std::auto_ptr removed in c++17:
	CXXFLAGS+=" -std=c++14"
	# Fix building with LLVM 19+ on libc++-based distros
	CPPFLAGS+="	-D UCS2=\"char16_t\""
	CPPFLAGS+="	-D UCS4=\"char32_t\""
}

clandro_step_create_debscripts() {
	local _POVRAY_VERSION_BASE="${CLANDRO_PKG_VERSION%-*}"
	_POVRAY_VERSION_BASE="${_POVRAY_VERSION_BASE%.*}"
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "povconfuser=\$HOME/.povray/${_POVRAY_VERSION_BASE}" >> postinst
	echo "mkdir -p \$povconfuser/" >> postinst
	echo "for f in povray.conf povray.ini; do" >> postinst
	echo "    if [ ! -f \$povconfuser/\$f ]; then" >> postinst
	echo "        cp $CLANDRO_PREFIX/etc/povray/${_POVRAY_VERSION_BASE}/\$f \$povconfuser/" >> postinst
	echo "    fi" >> postinst
	echo "done" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
