CLANDRO_PKG_HOMEPAGE=https://powdertoy.co.uk/
CLANDRO_PKG_DESCRIPTION="The Powder Toy is a free physics sandbox game"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="99.5.394"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ThePowderToy/The-Powder-Toy/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=71ab1a1b8e94d5c20f3845291f131dc8b80abe3fb74faa4cc85560849c7b8cda
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fftw, jsoncpp, libandroid-execinfo, libbz2, libc++, libcurl, luajit, libpng, sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dworkaround_elusive_bzip2_lib_dir=$CLANDRO_PREFIX/lib
-Dworkaround_elusive_bzip2_include_dir=$CLANDRO_PREFIX/include
-Db_pie=true
-Dignore_updates=true
-Dapp_data=$CLANDRO_ANDROID_HOME/.powdertoy
-Dcan_install=no
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin powder
	ln -sf powder $CLANDRO_PREFIX/bin/the-powder-toy
	install -Dm700 -t $CLANDRO_PREFIX/share/applications resources/powder.desktop
	install -Dm700 -T $CLANDRO_PKG_SRCDIR/resources/generated_icons/icon_exe.png $CLANDRO_PREFIX/share/pixmaps/powdertoy-powder.png
}
