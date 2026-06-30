CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/screen/
CLANDRO_PKG_DESCRIPTION="Terminal multiplexer with VT100/ANSI terminal emulation"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.0.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/screen/screen-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2dae36f4db379ffcd14b691596ba6ec18ac3a9e22bc47ac239789ab58409869d
# libandroid-support is necessary as screen uses `wcwidth`, see #22688
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses, clandro-auth"
CLANDRO_PKG_BUILD_DEPENDS="libcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-system_screenrc=$CLANDRO_PREFIX/etc/screenrc
--disable-socket-dir
--disable-pam
--enable-colors256
"

clandro_pkg_auto_update() {
	read -r latest < <(curl -fsSL "https://mirrors.kernel.org/gnu/screen" | sed -rn 's/.*screen-([0-9]+(\.[0-9]+)*).*/\1/p' | sort -Vr);
	clandro_pkg_upgrade_version "${latest}"
}

clandro_step_pre_configure() {
	# Run autoreconf since we have patched configure.ac
	autoreconf -fi
	CFLAGS+=" -DGETUTENT -Dindex=strchr -Drindex=strrchr"
	export LIBS="-lclandro-auth"
}

clandro_step_post_configure() {
	echo '#define HAVE_SVR4_PTYS 1' >> "$CLANDRO_PKG_BUILDDIR/config.h"
	echo 'mousetrack on' > "$CLANDRO_PREFIX/etc/screenrc"
	echo 'truecolor on' >> "$CLANDRO_PREFIX/etc/screenrc"
}
