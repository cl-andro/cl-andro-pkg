CLANDRO_PKG_HOMEPAGE=http://www.lenmus.org/
CLANDRO_PKG_DESCRIPTION="A free program to help you in the study of music theory and ear training"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=6.0.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/lenmus/lenmus/archive/refs/tags/Release_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1fa5b8edc468c800598845aa809b4a4e93058ed13af40bfacd037c44d1c4bc1d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="fluidsynth, fontconfig, freetype, libc++, libpng, libsqlite, portmidi, wxwidgets, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DFLUIDR3_PATH=$CLANDRO_PREFIX/share/soundfonts
-DLENMUS_COMPILER_GCC=0
-DLENMUS_COMPILER_MSVC=0
-DMAN_INSTALL_DIR=$CLANDRO_PREFIX/share/man
"

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "if [ ! -e $CLANDRO_PREFIX/share/soundfonts/FluidR3_GM.sf2 ]; then" >> postinst
	echo "  echo" >> postinst
	echo "  echo You may need to get \\\`FluidR3_GM.sf2\\' from somewhere and put it into:" >> postinst
	echo "  echo" >> postinst
	echo "  echo '    '$CLANDRO_PREFIX/share/soundfonts/" >> postinst
	echo "  echo" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
